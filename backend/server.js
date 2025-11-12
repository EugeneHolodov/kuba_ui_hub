const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { initDatabase } = require('./database/db');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
// CORS configuration - update allowed origins with your GitHub Pages URL
const allowedOrigins = [
  'http://localhost:3000',
  'http://localhost:8080',
  'https://*.github.io', // Allow all GitHub Pages domains
  // Add your specific GitHub Pages URL here, e.g.:
  // 'https://YOUR_USERNAME.github.io',
];

const corsOptions = {
  origin: function (origin, callback) {
    // Allow requests with no origin (like mobile apps or curl requests)
    if (!origin) return callback(null, true);
    
    // Check if origin is in allowed list or matches GitHub Pages pattern
    if (allowedOrigins.some(allowed => {
      if (allowed.includes('*')) {
        const pattern = allowed.replace('*', '.*');
        return new RegExp(pattern).test(origin);
      }
      return allowed === origin;
    })) {
      callback(null, true);
    } else {
      // For development, allow all origins (remove in production)
      if (process.env.NODE_ENV !== 'production') {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    }
  },
  credentials: true,
};

app.use(cors(corsOptions));
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

