const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// GET all users
router.get('/', (req, res) => {
  const db = getDB();
  db.all('SELECT * FROM users ORDER BY created_at DESC', [], (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json({ users: rows });
  });
  db.close();
});

// GET user by ID
router.get('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  
  db.get('SELECT * FROM users WHERE id = ?', [id], (err, row) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (!row) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    res.json({ user: row });
  });
  db.close();
});

// POST create new user
router.post('/', (req, res) => {
  const db = getDB();
  const { name, email } = req.body;
  
  if (!name || !email) {
    res.status(400).json({ error: 'Name and email are required' });
    return;
  }
  
  db.run(
    'INSERT INTO users (name, email) VALUES (?, ?)',
    [name, email],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.status(201).json({ 
        user: { 
          id: this.lastID, 
          name, 
          email,
          created_at: new Date().toISOString()
        } 
      });
    }
  );
  db.close();
});

// PUT update user
router.put('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  const { name, email } = req.body;
  
  db.run(
    'UPDATE users SET name = ?, email = ? WHERE id = ?',
    [name, email, id],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (this.changes === 0) {
        res.status(404).json({ error: 'User not found' });
        return;
      }
      res.json({ message: 'User updated successfully', id });
    }
  );
  db.close();
});

// DELETE user
router.delete('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  
  db.run('DELETE FROM users WHERE id = ?', [id], function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    res.json({ message: 'User deleted successfully' });
  });
  db.close();
});

module.exports = router;

