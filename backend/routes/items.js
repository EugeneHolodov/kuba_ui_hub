const express = require('express');
const router = express.Router();
const { getDB } = require('../database/db');

// GET all items
router.get('/', async (req, res) => {
  const pool = getDB();
  const category = req.query.category;
  
  try {
    let query = 'SELECT * FROM items ORDER BY created_at DESC';
    let params = [];
    
    if (category) {
      query = 'SELECT * FROM items WHERE category = $1 ORDER BY created_at DESC';
      params = [category];
    }
    
    const result = await pool.query(query, params);
    res.json({ items: result.rows });
  } catch (err) {
    console.error('Error fetching items:', err);
    res.status(500).json({ error: err.message });
  }
});

// GET item by ID
router.get('/:id', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  
  try {
    const result = await pool.query('SELECT * FROM items WHERE id = $1', [id]);
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Item not found' });
      return;
    }
    
    res.json({ item: result.rows[0] });
  } catch (err) {
    console.error('Error fetching item:', err);
    res.status(500).json({ error: err.message });
  }
});

// POST create new item
router.post('/', async (req, res) => {
  const pool = getDB();
  const { title, description, category } = req.body;
  
  if (!title) {
    res.status(400).json({ error: 'Title is required' });
    return;
  }
  
  try {
    const result = await pool.query(
      'INSERT INTO items (title, description, category) VALUES ($1, $2, $3) RETURNING *',
      [title, description || null, category || null]
    );
    
    res.status(201).json({ item: result.rows[0] });
  } catch (err) {
    console.error('Error creating item:', err);
    res.status(500).json({ error: err.message });
  }
});

// PUT update item
router.put('/:id', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  const { title, description, category } = req.body;
  
  try {
    const result = await pool.query(
      'UPDATE items SET title = $1, description = $2, category = $3, updated_at = CURRENT_TIMESTAMP WHERE id = $4 RETURNING *',
      [title, description, category, id]
    );
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Item not found' });
      return;
    }
    
    res.json({ message: 'Item updated successfully', item: result.rows[0] });
  } catch (err) {
    console.error('Error updating item:', err);
    res.status(500).json({ error: err.message });
  }
});

// DELETE item
router.delete('/:id', async (req, res) => {
  const pool = getDB();
  const id = req.params.id;
  
  try {
    const result = await pool.query('DELETE FROM items WHERE id = $1 RETURNING id', [id]);
    
    if (result.rows.length === 0) {
      res.status(404).json({ error: 'Item not found' });
      return;
    }
    
    res.json({ message: 'Item deleted successfully' });
  } catch (err) {
    console.error('Error deleting item:', err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

