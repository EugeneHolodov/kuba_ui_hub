const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// POST create new review
router.post('/', (req, res) => {
  const db = getDB();
  const { reviewer_id, widget_name, comment } = req.body;
  
  // Validate required fields
  if (reviewer_id === undefined || reviewer_id === null) {
    res.status(400).json({ error: 'reviewer_id is required' });
    return;
  }
  
  if (!widget_name || widget_name.trim() === '') {
    res.status(400).json({ error: 'widget_name is required' });
    return;
  }
  
  if (!comment || comment.trim() === '') {
    res.status(400).json({ error: 'comment is required' });
    return;
  }
  
  // First verify that the reviewer_id exists
  db.get('SELECT id, name FROM reviewers WHERE id = ?', [reviewer_id], (err, reviewer) => {
    if (err) {
      res.status(500).json({ error: err.message });
      db.close();
      return;
    }
    
    if (!reviewer) {
      res.status(400).json({ error: `Reviewer with id ${reviewer_id} does not exist` });
      db.close();
      return;
    }
    
    // Insert the review
    db.run(
      'INSERT INTO reviews (reviewer_id, widget_name, comment) VALUES (?, ?, ?)',
      [reviewer_id, widget_name.trim(), comment.trim()],
      function(insertErr) {
        if (insertErr) {
          res.status(500).json({ error: insertErr.message });
          db.close();
          return;
        }
        
        res.status(201).json({ 
          success: true,
          review: { 
            id: this.lastID, 
            reviewer_id,
            reviewer_name: reviewer.name,
            widget_name: widget_name.trim(),
            comment: comment.trim(),
            created_at: new Date().toISOString()
          } 
        });
        db.close();
      }
    );
  });
});

// GET all reviews (for developers to see comments)
router.get('/', (req, res) => {
  const db = getDB();
  const widgetName = req.query.widget_name;
  
  let query = `
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
  `;
  
  let params = [];
  
  if (widgetName) {
    query = `
      SELECT 
        r.id,
        r.reviewer_id,
        rev.name as reviewer_name,
        r.widget_name,
        r.comment,
        r.created_at
      FROM reviews r
      INNER JOIN reviewers rev ON r.reviewer_id = rev.id
      WHERE r.widget_name = ?
      ORDER BY r.created_at DESC
    `;
    params = [widgetName];
  }
  
  db.all(query, params, (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      db.close();
      return;
    }
    res.json({ reviews: rows });
    db.close();
  });
});

// GET reviews by widget name
router.get('/widget/:widget_name', (req, res) => {
  const db = getDB();
  const widgetName = req.params.widget_name;
  
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
    WHERE r.widget_name = ?
    ORDER BY r.created_at DESC
  `, [widgetName], (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      db.close();
      return;
    }
    res.json({ reviews: rows });
    db.close();
  });
});

// GET all reviewers (helper endpoint)
router.get('/reviewers', (req, res) => {
  const db = getDB();
  
  db.all('SELECT id, name FROM reviewers ORDER BY id', [], (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      db.close();
      return;
    }
    res.json({ reviewers: rows });
    db.close();
  });
});

module.exports = router;

