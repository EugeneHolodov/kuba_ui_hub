const { Pool } = require('pg');

// PostgreSQL connection pool
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Test connection
pool.on('connect', () => {
  console.log('Connected to PostgreSQL database');
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
  process.exit(-1);
});

// Get database connection from pool
function getDB() {
  return pool;
}

// Initialize database tables
async function initDatabase() {
  const client = await pool.connect();
  
  try {
    // Start transaction
    await client.query('BEGIN');

    // Reviewers table
    await client.query(`
      CREATE TABLE IF NOT EXISTS reviewers (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      )
    `);
    console.log('Reviewers table ready');

    // Reviews table
    await client.query(`
      CREATE TABLE IF NOT EXISTS reviews (
        id SERIAL PRIMARY KEY,
        reviewer_id INTEGER NOT NULL,
        widget_name TEXT NOT NULL,
        comment TEXT NOT NULL,
        is_processed BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
      )
    `);
    console.log('Reviews table ready');

    // Add is_processed column if it doesn't exist (for existing databases)
    try {
      await client.query(`
        ALTER TABLE reviews 
        ADD COLUMN IF NOT EXISTS is_processed BOOLEAN DEFAULT FALSE
      `);
      console.log('Added is_processed column to reviews table');
    } catch (err) {
      // Column might already exist, ignore error
      console.log('is_processed column already exists or error adding it');
    }

    // Users table (keeping for backward compatibility)
    await client.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('Users table ready');

    // Items table (keeping for backward compatibility)
    await client.query(`
      CREATE TABLE IF NOT EXISTS items (
        id SERIAL PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('Items table ready');

    // Seed reviewers
    await seedReviewers(client);

    // Commit transaction
    await client.query('COMMIT');
    console.log('Database initialized successfully');
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Error initializing database:', err.message);
    throw err;
  } finally {
    client.release();
  }
}

// Seed reviewers table with initial data
async function seedReviewers(client) {
  const reviewers = [
    { id: 0, name: 'Lars' },
    { id: 1, name: 'Nick' },
    { id: 2, name: 'Leo' },
    { id: 3, name: 'Hallvard' },
    { id: 4, name: 'Benjamin' },
    { id: 5, name: 'Anita' },
    { id: 6, name: 'Eugene' },
    { id: 7, name: 'Gest' },
    { id: 8, name: 'Ragul' },
    { id: 9, name: 'Vijay' }
  ];

  for (const reviewer of reviewers) {
    try {
      await client.query(
        'INSERT INTO reviewers (id, name) VALUES ($1, $2) ON CONFLICT (id) DO NOTHING',
        [reviewer.id, reviewer.name]
      );
    } catch (err) {
      console.error(`Error inserting reviewer ${reviewer.name}:`, err.message);
    }
  }
  
  console.log('Reviewers seeded successfully');
}

module.exports = {
  getDB,
  initDatabase,
  pool
};

