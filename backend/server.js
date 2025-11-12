const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { initDatabase } = require('./database/db');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Initialize database
initDatabase();

// Routes
app.get('/', (req, res) => {
  res.json({ 
    message: 'Welcome to Kuba UI Hub API',
    version: '1.0.0',
    endpoints: {
      reviews: '/api/reviews',
      reviewers: '/api/reviewers',
      users: '/api/users',
      items: '/api/items'
    }
  });
});

app.use('/api/reviews', require('./routes/reviews'));
app.use('/api/reviewers', require('./routes/reviewers'));
app.use('/api/users', require('./routes/users'));
app.use('/api/items', require('./routes/items'));

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`API endpoints available at http://localhost:${PORT}/api`);
});

