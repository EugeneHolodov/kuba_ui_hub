const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// Admin page to view all reviews
router.get('/', (req, res) => {
  const db = getDB();
  
  // Get all reviews with reviewer names
  db.all(`
    SELECT 
      r.id,
      r.reviewer_id,
      rev.name as reviewer_name,
      r.widget_name,
      r.comment,
      r.created_at
    FROM reviews r
    INNER JOIN reviewers rev ON r.reviewer_id = rev.id
    ORDER BY r.created_at DESC
  `, [], (err, reviews) => {
    if (err) {
      res.status(500).send(`<h1>Error</h1><p>${err.message}</p>`);
      db.close();
      return;
    }
    
    // Get statistics
    db.all(`
      SELECT 
        widget_name,
        COUNT(*) as count
      FROM reviews
      GROUP BY widget_name
      ORDER BY count DESC
    `, [], (err, stats) => {
      db.close();
      
      if (err) {
        res.status(500).send(`<h1>Error</h1><p>${err.message}</p>`);
        return;
      }
      
      // Generate HTML page
      const html = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Kuba UI Hub - Admin Dashboard</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: #f5f5f5;
      padding: 20px;
      color: #333;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
    }
    h1 {
      color: #93328E;
      margin-bottom: 10px;
    }
    .subtitle {
      color: #666;
      margin-bottom: 30px;
    }
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }
    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .stat-card h3 {
      color: #93328E;
      font-size: 24px;
      margin-bottom: 5px;
    }
    .stat-card p {
      color: #666;
      font-size: 14px;
    }
    .reviews {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      overflow: hidden;
    }
    .review-item {
      padding: 20px;
      border-bottom: 1px solid #eee;
    }
    .review-item:last-child {
      border-bottom: none;
    }
    .review-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }
    .reviewer-name {
      font-weight: bold;
      color: #93328E;
    }
    .widget-name {
      background: #F1B434;
      color: #000;
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 600;
    }
    .review-comment {
      color: #333;
      line-height: 1.6;
      margin-bottom: 8px;
    }
    .review-date {
      color: #999;
      font-size: 12px;
    }
    .empty {
      text-align: center;
      padding: 60px 20px;
      color: #999;
    }
    .refresh-btn {
      background: #93328E;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      margin-bottom: 20px;
    }
    .refresh-btn:hover {
      background: #7a2575;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Kuba UI Hub - Admin Dashboard</h1>
    <p class="subtitle">View and manage all reviews</p>
    
    <button class="refresh-btn" onclick="location.reload()">🔄 Refresh</button>
    
    <div class="stats">
      <div class="stat-card">
        <h3>${reviews.length}</h3>
        <p>Total Reviews</p>
      </div>
      <div class="stat-card">
        <h3>${stats.length}</h3>
        <p>Widgets Reviewed</p>
      </div>
      <div class="stat-card">
        <h3>${new Set(reviews.map(r => r.reviewer_name)).size}</h3>
        <p>Active Reviewers</p>
      </div>
    </div>
    
    <div class="reviews">
      ${reviews.length === 0 ? 
        '<div class="empty"><h2>No reviews yet</h2><p>Reviews will appear here once users submit feedback</p></div>' :
        reviews.map(review => `
          <div class="review-item">
            <div class="review-header">
              <span class="reviewer-name">${escapeHtml(review.reviewer_name)}</span>
              <span class="widget-name">${escapeHtml(review.widget_name)}</span>
            </div>
            <div class="review-comment">${escapeHtml(review.comment)}</div>
            <div class="review-date">${formatDate(review.created_at)}</div>
          </div>
        `).join('')
      }
    </div>
  </div>
  
  <script>
    // Auto-refresh every 30 seconds
    setTimeout(() => location.reload(), 30000);
  </script>
</body>
</html>
      `;
      
      res.send(html);
    });
  });
});

// Helper function to escape HTML
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;'
  };
  return String(text).replace(/[&<>"']/g, m => map[m]);
}

// Helper function to format date
function formatDate(dateString) {
  const date = new Date(dateString);
  return date.toLocaleString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
}

module.exports = router;

