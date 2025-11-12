# Database Management Guide

## Viewing Your Reviews

### Option 1: Admin Dashboard (Recommended)

After deploying your backend, you can access the admin dashboard at:

```
https://your-backend-url.onrender.com/admin
```

or

```
https://your-backend-url.up.railway.app/admin
```

**Features:**
- ✅ View all reviews in a nice, readable format
- ✅ See statistics (total reviews, widgets reviewed, active reviewers)
- ✅ Auto-refreshes every 30 seconds
- ✅ Shows reviewer name, widget name, comment, and date
- ✅ Clean, modern interface

### Option 2: API Endpoint

You can also access reviews via the API:

**Get all reviews:**
```
GET https://your-backend-url.onrender.com/api/reviews
```

**Get reviews for a specific widget:**
```
GET https://your-backend-url.onrender.com/api/reviews?widget_name=kuba_input
```

**Get reviews by widget name:**
```
GET https://your-backend-url.onrender.com/api/reviews/widget/kuba_input
```

### Option 3: Direct Database Access (Advanced)

If you need direct database access:

#### For Render.com:
1. Go to your Render dashboard
2. Select your backend service
3. Go to **Shell** tab
4. Run: `sqlite3 database/kuba_hub.db`
5. Then run SQL queries:
   ```sql
   SELECT * FROM reviews;
   SELECT * FROM reviewers;
   ```

#### For Railway.app:
1. Go to your Railway dashboard
2. Select your service
3. Click **Deployments** → **View Logs**
4. Or use Railway CLI to access the database

#### Using SQLite Browser (Local):
1. Download [DB Browser for SQLite](https://sqlitebrowser.org/)
2. Connect to your database file: `backend/database/kuba_hub.db`
3. Browse tables and run queries

## Database Schema

### Reviews Table
```sql
CREATE TABLE reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  reviewer_id INTEGER NOT NULL,
  widget_name TEXT NOT NULL,
  comment TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);
```

### Reviewers Table
```sql
CREATE TABLE reviewers (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);
```

## Useful SQL Queries

**View all reviews:**
```sql
SELECT 
  r.id,
  rev.name as reviewer_name,
  r.widget_name,
  r.comment,
  r.created_at
FROM reviews r
INNER JOIN reviewers rev ON r.reviewer_id = rev.id
ORDER BY r.created_at DESC;
```

**Count reviews per widget:**
```sql
SELECT 
  widget_name,
  COUNT(*) as count
FROM reviews
GROUP BY widget_name
ORDER BY count DESC;
```

**Count reviews per reviewer:**
```sql
SELECT 
  rev.name,
  COUNT(*) as count
FROM reviews r
INNER JOIN reviewers rev ON r.reviewer_id = rev.id
GROUP BY rev.name
ORDER BY count DESC;
```

**Recent reviews (last 24 hours):**
```sql
SELECT 
  rev.name as reviewer_name,
  r.widget_name,
  r.comment,
  r.created_at
FROM reviews r
INNER JOIN reviewers rev ON r.reviewer_id = rev.id
WHERE r.created_at >= datetime('now', '-1 day')
ORDER BY r.created_at DESC;
```

## Backup Your Database

### On Render.com:
1. Use the Shell tab to access your service
2. Download the database file:
   ```bash
   # The database is at: database/kuba_hub.db
   ```

### On Railway.app:
1. Use Railway CLI or dashboard
2. Download the database file from your service

### Manual Backup:
```bash
# Copy the database file
cp backend/database/kuba_hub.db backup/kuba_hub_backup_$(date +%Y%m%d).db
```

## Troubleshooting

**Can't access admin page?**
- Make sure your backend is deployed and running
- Check the URL is correct: `https://your-backend-url/admin`
- Verify the route is registered in `server.js`

**No reviews showing?**
- Check if reviews table exists: The database auto-creates on first run
- Verify reviews are being submitted from your Flutter app
- Check backend logs for errors

**Database locked errors?**
- SQLite can have locking issues with multiple connections
- The current implementation closes connections after each query
- If issues persist, consider upgrading to PostgreSQL (for production)

