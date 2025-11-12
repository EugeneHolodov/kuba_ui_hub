const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const DB_PATH = path.join(__dirname, 'kuba_hub.db');

// Create and return database connection
function getDB() {
  return new sqlite3.Database(DB_PATH, (err) => {
    if (err) {
      console.error('Error opening database:', err.message);
    } else {
      console.log('Connected to SQLite database');
    }
  });
}

// Initialize database tables
function initDatabase() {
  const db = getDB();
  
  // Reviewers table
  db.run(`CREATE TABLE IF NOT EXISTS reviewers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
  )`, (err) => {
    if (err) {
      console.error('Error creating reviewers table:', err.message);
    } else {
      console.log('Reviewers table ready');
      // Seed reviewers table with initial data
      seedReviewers(db);
    }
  });

  // Reviews table
  db.run(`CREATE TABLE IF NOT EXISTS reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reviewer_id INTEGER NOT NULL,
    widget_name TEXT NOT NULL,
    comment TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
  )`, (err) => {
    if (err) {
      console.error('Error creating reviews table:', err.message);
    } else {
      console.log('Reviews table ready');
    }
  });

  // Users table (keeping for backward compatibility)
  db.run(`CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  )`, (err) => {
    if (err) {
      console.error('Error creating users table:', err.message);
    } else {
      console.log('Users table ready');
    }
  });

  // Items table (keeping for backward compatibility)
  db.run(`CREATE TABLE IF NOT EXISTS items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    category TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
  )`, (err) => {
    if (err) {
      console.error('Error creating items table:', err.message);
    } else {
      console.log('Items table ready');
      // Close connection only after all tables are created
      db.close((err) => {
        if (err) {
          console.error('Error closing database:', err.message);
        }
      });
    }
  });
}

// Seed reviewers table with initial data
function seedReviewers(db) {
  const reviewers = [
    { id: 0, name: 'Lars' },
    { id: 1, name: 'Nick' },
    { id: 2, name: 'Leo' },
    { id: 3, name: 'Hallvard' },
    { id: 4, name: 'Benjamin' },
    { id: 5, name: 'Anita' },
    { id: 6, name: 'Eugene' },
    { id: 7, name: 'Gest' }
  ];

  // Use INSERT OR IGNORE to avoid errors if reviewers already exist
  const stmt = db.prepare('INSERT OR IGNORE INTO reviewers (id, name) VALUES (?, ?)');
  
  reviewers.forEach(reviewer => {
    stmt.run([reviewer.id, reviewer.name], (err) => {
      if (err) {
        console.error(`Error inserting reviewer ${reviewer.name}:`, err.message);
      }
    });
  });
  
  stmt.finalize((err) => {
    if (err) {
      console.error('Error finalizing reviewers seed:', err.message);
    } else {
      console.log('Reviewers seeded successfully');
    }
  });
}

module.exports = {
  getDB,
  initDatabase,
  DB_PATH
};

