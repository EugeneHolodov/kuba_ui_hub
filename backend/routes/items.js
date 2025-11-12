const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// GET all items
router.get('/', (req, res) => {
  const db = getDB();
  const category = req.query.category;
  
  let query = 'SELECT * FROM items ORDER BY created_at DESC';
  let params = [];
  
  if (category) {
    query = 'SELECT * FROM items WHERE category = ? ORDER BY created_at DESC';
    params = [category];
  }
  
  db.all(query, params, (err, rows) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    res.json({ items: rows });
  });
  db.close();
});

// GET item by ID
router.get('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  
  db.get('SELECT * FROM items WHERE id = ?', [id], (err, row) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (!row) {
      res.status(404).json({ error: 'Item not found' });
      return;
    }
    res.json({ item: row });
  });
  db.close();
});

// POST create new item
router.post('/', (req, res) => {
  const db = getDB();
  const { title, description, category } = req.body;
  
  if (!title) {
    res.status(400).json({ error: 'Title is required' });
    return;
  }
  
  db.run(
    'INSERT INTO items (title, description, category) VALUES (?, ?, ?)',
    [title, description || null, category || null],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      res.status(201).json({ 
        item: { 
          id: this.lastID, 
          title, 
          description,
          category,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        } 
      });
    }
  );
  db.close();
});

// PUT update item
router.put('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  const { title, description, category } = req.body;
  
  db.run(
    'UPDATE items SET title = ?, description = ?, category = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?',
    [title, description, category, id],
    function(err) {
      if (err) {
        res.status(500).json({ error: err.message });
        return;
      }
      if (this.changes === 0) {
        res.status(404).json({ error: 'Item not found' });
        return;
      }
      res.json({ message: 'Item updated successfully', id });
    }
  );
  db.close();
});

// DELETE item
router.delete('/:id', (req, res) => {
  const db = getDB();
  const id = req.params.id;
  
  db.run('DELETE FROM items WHERE id = ?', [id], function(err) {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }
    if (this.changes === 0) {
      res.status(404).json({ error: 'Item not found' });
      return;
    }
    res.json({ message: 'Item deleted successfully' });
  });
  db.close();
});

module.exports = router;

