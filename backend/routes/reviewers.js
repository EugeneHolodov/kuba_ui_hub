const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// GET all reviewers
router.get('/', async (req, res) => {
  const pool = getDB();
  
  try {
    const result = await pool.query('SELECT id, name FROM reviewers ORDER BY id');
    res.json({ reviewers: result.rows });
  } catch (err) {
    console.error('Error fetching reviewers:', err);
    res.status(500).json({ error: err.message });
  }
});

// GET reviewer by ID
router.get('/:id', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  
  try {
    const result = await pool.query('SELECT id, name FROM reviewers WHERE id = $1', [id]);
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Reviewer not found' });
      return;
    }
    
    res.json({ reviewer: result.rows[0] });
  } catch (err) {
    console.error('Error fetching reviewer:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

