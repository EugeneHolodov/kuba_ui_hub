const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// GET all reviewers
router.get('/', (req, res) => {
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

// GET reviewer by ID
router.get('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  
  db.get('SELECT id, name FROM reviewers WHERE id = ?', [id], (err, row) => {
    if (err) {
      res.status(500).json({ error: err.message });
      db.close();
      return;
    }
    if (!row) {
      res.status(404).json({ error: 'Reviewer not found' });
      db.close();
      return;
    }
    res.json({ reviewer: row });
    db.close();
  });
});

module.exports = router;

