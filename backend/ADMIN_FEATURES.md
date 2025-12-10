# 🎯 Admin Dashboard Features

## 📊 Overview

The admin dashboard provides powerful tools to manage reviews submitted by users.

Access at: `https://your-backend.onrender.com/admin`

---

## ✨ Features

### 1. **View All Reviews**
- See all reviews in chronological order (newest first)
- Unprocessed reviews appear first for easy management
- Visual indicators for processed/pending status

### 2. **Review Status Management**
Each review shows:
- ✅ **Processed** - Review has been addressed
- ⏳ **Pending** - Review awaiting action

### 3. **Action Buttons**

#### Mark as Processed ✓
- Click "Mark as Processed" to indicate you've addressed the review
- Processed reviews appear with a blue background and lower opacity
- Helps track which feedback has been handled

#### Mark as Unprocessed ↩️
- Revert a processed review back to pending status
- Useful if you need to revisit the feedback

#### Delete 🗑️
- Permanently remove a review from the database
- Confirmation dialog prevents accidental deletions
- **Warning:** This action cannot be undone!

---

## 📈 Statistics Dashboard

The admin page displays:
1. **Total Reviews** - All reviews in the system
2. **Processed Reviews** - Reviews marked as completed
3. **Pending Reviews** - Reviews awaiting action
4. **Widgets Reviewed** - Number of unique widgets with feedback
5. **Active Reviewers** - Number of team members providing feedback

---

## 🔧 API Endpoints

### Delete Review
```http
DELETE /api/reviews/:id
```

**Response:**
```json
{
  "success": true,
  "message": "Review deleted successfully",
  "id": 123
}
```

### Mark Review as Processed
```http
PATCH /api/reviews/:id/process
Content-Type: application/json

{
  "is_processed": true
}
```

**Response:**
```json
{
  "success": true,
  "message": "Review marked as processed",
  "review": {
    "id": 123,
    "reviewer_id": 6,
    "widget_name": "kuba_dropdown",
    "comment": "Great component!",
    "is_processed": true,
    "created_at": "2024-01-15T10:30:00.000Z"
  }
}
```

---

## 🗄️ Database Schema Update

The `reviews` table now includes:
```sql
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  reviewer_id INTEGER NOT NULL,
  widget_name TEXT NOT NULL,
  comment TEXT NOT NULL,
  is_processed BOOLEAN DEFAULT FALSE,  -- NEW FIELD
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);
```

---

## 🚀 How to Use

### Managing Reviews

1. **Open Admin Dashboard**
   ```
   https://kuba-ui-hub-backend.onrender.com/admin
   ```

2. **Review Feedback**
   - Read through pending reviews (orange "Pending" badge)
   - Take necessary actions based on feedback

3. **Mark as Processed**
   - Once you've addressed feedback, click "✓ Mark as Processed"
   - Review moves to bottom of list with blue background

4. **Delete Spam/Invalid Reviews**
   - Click "🗑️ Delete" button
   - Confirm deletion in dialog
   - Review is permanently removed

---

## 🔄 Auto-Refresh

The admin page automatically refreshes every **60 seconds** to show new reviews.

You can also manually refresh by clicking the "🔄 Refresh" button at the top.

---

## 🎨 Visual Indicators

| Status | Badge | Background | Meaning |
|--------|-------|------------|---------|
| Pending | ⏳ Orange | White | Needs attention |
| Processed | ✓ Green | Light Blue | Completed |

---

## 🔒 Security Notes

⚠️ **Important:** The admin endpoint currently has no authentication!

**For production, you should:**
1. Add authentication middleware
2. Require admin credentials
3. Use HTTPS only
4. Add rate limiting
5. Log all admin actions

### Example Security Implementation:

```javascript
// middleware/auth.js
function requireAdmin(req, res, next) {
  const apiKey = req.headers['x-api-key'];
  
  if (apiKey !== process.env.ADMIN_API_KEY) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  
  next();
}

// In routes/admin.js
router.get('/', requireAdmin, async (req, res) => {
  // ... admin logic
});
```

---

## 📝 Workflow Example

### Daily Review Management:

1. **Morning:**
   - Open admin dashboard
   - Review new feedback (pending reviews at top)
   - Prioritize critical issues

2. **Take Action:**
   - Create tickets for bugs
   - Update documentation
   - Improve components based on feedback

3. **Mark Complete:**
   - Mark reviews as processed after addressing
   - Add internal notes if needed

4. **Clean Up:**
   - Delete spam or test reviews
   - Archive old processed reviews periodically

---

## 🐛 Troubleshooting

### Review won't delete
- Check browser console for errors
- Verify backend is running
- Check database connection

### Status won't update
- Ensure database migration ran successfully
- Check `is_processed` column exists
- Verify API endpoint is accessible

### Stats not showing correctly
- Refresh the page
- Check database queries in logs
- Verify all reviews have `is_processed` field

---

## 📊 Future Enhancements

Potential improvements:
- [ ] Filter reviews by widget
- [ ] Filter by processed/pending status
- [ ] Search functionality
- [ ] Export reviews to CSV
- [ ] Add notes/comments to reviews
- [ ] Email notifications for new reviews
- [ ] Bulk actions (delete/process multiple)
- [ ] Review analytics and trends

---

**Happy managing! 🎉**
