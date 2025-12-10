const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// Admin page to view all reviews
router.get('/', async (req, res) => {
  const pool = getDB();
  
  try {
    // Get all reviews with reviewer names
    const reviewsResult = await pool.query(`
      SELECT 
        r.id,
        r.reviewer_id,
        rev.name as reviewer_name,
        r.widget_name,
        r.comment,
        r.is_processed,
        r.created_at
      FROM reviews r
      INNER JOIN reviewers rev ON r.reviewer_id = rev.id
      ORDER BY r.is_processed ASC, r.created_at DESC
    `);
    
    const reviews = reviewsResult.rows;
    
    // Get statistics
    const statsResult = await pool.query(`
      SELECT 
        widget_name,
        COUNT(*) as count
      FROM reviews
      GROUP BY widget_name
      ORDER BY count DESC
    `);
    
    const stats = statsResult.rows;
    
    // Get processed count
    const processedCountResult = await pool.query(`
      SELECT COUNT(*) as count FROM reviews WHERE is_processed = true
    `);
    const processedCount = processedCountResult.rows[0]?.count || 0;
    
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
      transition: background-color 0.2s;
    }
    .review-item:last-child {
      border-bottom: none;
    }
    .review-item.processed {
      background-color: #f0f9ff;
      opacity: 0.7;
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
    .review-actions {
      margin-top: 12px;
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
    }
    .btn {
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 12px;
      font-weight: 500;
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }
    .btn:hover {
      transform: translateY(-1px);
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .btn:active {
      transform: translateY(0);
    }
    .btn-delete {
      background: #dc2626;
      color: white;
    }
    .btn-delete:hover {
      background: #b91c1c;
    }
    .btn-process {
      background: #059669;
      color: white;
    }
    .btn-process:hover {
      background: #047857;
    }
    .btn-unprocess {
      background: #f59e0b;
      color: white;
    }
    .btn-unprocess:hover {
      background: #d97706;
    }
    .status-badge {
      display: inline-block;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
    }
    .status-processed {
      background: #d1fae5;
      color: #065f46;
    }
    .status-pending {
      background: #fed7aa;
      color: #9a3412;
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
        <h3>${processedCount}</h3>
        <p>Processed Reviews</p>
      </div>
      <div class="stat-card">
        <h3>${reviews.length - processedCount}</h3>
        <p>Pending Reviews</p>
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
          <div class="review-item ${review.is_processed ? 'processed' : ''}" id="review-${review.id}">
            <div class="review-header">
              <div style="display: flex; align-items: center; gap: 8px;">
                <span class="reviewer-name">${escapeHtml(review.reviewer_name)}</span>
                <span class="status-badge ${review.is_processed ? 'status-processed' : 'status-pending'}">
                  ${review.is_processed ? '✓ Processed' : '⏳ Pending'}
                </span>
              </div>
              <span class="widget-name">${escapeHtml(review.widget_name)}</span>
            </div>
            <div class="review-comment">${escapeHtml(review.comment)}</div>
            <div class="review-date">${formatDate(review.created_at)} • ID: ${review.id}</div>
            <div class="review-actions">
              ${review.is_processed ? `
                <button class="btn btn-unprocess" onclick="toggleProcess(${review.id}, false)">
                  ↩️ Mark as Unprocessed
                </button>
              ` : `
                <button class="btn btn-process" onclick="toggleProcess(${review.id}, true)">
                  ✓ Mark as Processed
                </button>
              `}
              <button class="btn btn-delete" onclick="deleteReview(${review.id})">
                🗑️ Delete
              </button>
            </div>
          </div>
        `).join('')
      }
    </div>
  </div>
  
  <script>
    // Delete review
    async function deleteReview(id) {
      if (!confirm('Are you sure you want to delete this review? This action cannot be undone.')) {
        return;
      }
      
      try {
        const response = await fetch(\`/api/reviews/\${id}\`, {
          method: 'DELETE',
        });
        
        const data = await response.json();
        
        if (response.ok) {
          // Remove review from DOM with animation
          const reviewElement = document.getElementById(\`review-\${id}\`);
          if (reviewElement) {
            reviewElement.style.transition = 'all 0.3s';
            reviewElement.style.opacity = '0';
            reviewElement.style.transform = 'translateX(-20px)';
            setTimeout(() => {
              reviewElement.remove();
              // Check if no reviews left
              const reviewsContainer = document.querySelector('.reviews');
              if (reviewsContainer && reviewsContainer.children.length === 0) {
                location.reload();
              }
            }, 300);
          }
        } else {
          alert('Error: ' + (data.error || 'Failed to delete review'));
        }
      } catch (error) {
        alert('Error: ' + error.message);
      }
    }
    
    // Toggle processed status
    async function toggleProcess(id, isProcessed) {
      try {
        const response = await fetch(\`/api/reviews/\${id}/process\`, {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ is_processed: isProcessed }),
        });
        
        const data = await response.json();
        
        if (response.ok) {
          // Reload page to show updated status
          location.reload();
        } else {
          alert('Error: ' + (data.error || 'Failed to update review status'));
        }
      } catch (error) {
        alert('Error: ' + error.message);
      }
    }
    
    // Auto-refresh every 60 seconds
    setTimeout(() => location.reload(), 60000);
  </script>
</body>
</html>
      `;
      
    res.send(html);
  } catch (err) {
    console.error('Error in admin page:', err);
    res.status(500).send(`<h1>Error</h1><p>${err.message}</p>`);
  }
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

