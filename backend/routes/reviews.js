const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// POST create new review
router.post('/', async (req, res) => {
  const pool = getDB();
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
  
  try {
    // First verify that the reviewer_id exists
    const reviewerResult = await pool.query(
      'SELECT id, name FROM reviewers WHERE id = $1',
      [reviewer_id]
    );
    
    if (reviewerResult.rows.length === 0) {
      res.status(400).json({ error: `Reviewer with id ${reviewer_id} does not exist` });
      return;
    }
    
    const reviewer = reviewerResult.rows[0];
    
    // Insert the review
    const insertResult = await pool.query(
      'INSERT INTO reviews (reviewer_id, widget_name, comment) VALUES ($1, $2, $3) RETURNING *',
      [reviewer_id, widget_name.trim(), comment.trim()]
    );
    
    const newReview = insertResult.rows[0];
    
    res.status(201).json({ 
      success: true,
      review: { 
        id: newReview.id, 
        reviewer_id: newReview.reviewer_id,
        reviewer_name: reviewer.name,
        widget_name: newReview.widget_name,
        comment: newReview.comment,
        created_at: newReview.created_at
      } 
    });
  } catch (err) {
    console.error('Error creating review:', err);
    res.status(500).json({ error: err.message });
  }
});

// GET all reviews (for developers to see comments)
router.get('/', async (req, res) => {
  const pool = getDB();
  const widgetName = req.query.widget_name;
  
  try {
    let query = `
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
          r.is_processed,
          r.created_at
        FROM reviews r
        INNER JOIN reviewers rev ON r.reviewer_id = rev.id
        WHERE r.widget_name = $1
        ORDER BY r.created_at DESC
      `;
      params = [widgetName];
    }
    
    const result = await pool.query(query, params);
    res.json({ reviews: result.rows });
  } catch (err) {
    console.error('Error fetching reviews:', err);
    res.status(500).json({ error: err.message });
  }
});

// GET reviews by widget name
router.get('/widget/:widget_name', async (req, res) => {
  const pool = getDB();
  const widgetName = req.params.widget_name;
  
  try {
    const result = await pool.query(`
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
      WHERE r.widget_name = $1
      ORDER BY r.created_at DESC
    `, [widgetName]);
    
    res.json({ reviews: result.rows });
  } catch (err) {
    console.error('Error fetching widget reviews:', err);
    res.status(500).json({ error: err.message });
  }
});

// GET all reviewers (helper endpoint)
router.get('/reviewers', async (req, res) => {
  const pool = getDB();
  
  try {
    const result = await pool.query('SELECT id, name FROM reviewers ORDER BY id');
    res.json({ reviewers: result.rows });
  } catch (err) {
    console.error('Error fetching reviewers:', err);
    res.status(500).json({ error: err.message });
  }
});

// DELETE review by ID (admin only)
router.delete('/:id', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  
  try {
    const result = await pool.query(
      'DELETE FROM reviews WHERE id = $1 RETURNING id',
      [id]
    );
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Review not found' });
      return;
    }
    
    res.json({ 
      success: true,
      message: 'Review deleted successfully',
      id: result.rows[0].id
    });
  } catch (err) {
    console.error('Error deleting review:', err);
    res.status(500).json({ error: err.message });
  }
});

// PATCH mark review as processed (admin only)
router.patch('/:id/process', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  const { is_processed } = req.body;
  
  try {
    const result = await pool.query(
      'UPDATE reviews SET is_processed = $1 WHERE id = $2 RETURNING *',
      [is_processed !== undefined ? is_processed : true, id]
    );
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Review not found' });
      return;
    }
    
    res.json({ 
      success: true,
      message: `Review marked as ${result.rows[0].is_processed ? 'processed' : 'unprocessed'}`,
      review: result.rows[0]
    });
  } catch (err) {
    console.error('Error updating review:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

