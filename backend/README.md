# Kuba UI Hub Backend API

A robust REST API backend for the Kuba UI Hub Flutter application, built with Node.js, Express, and PostgreSQL.

## Features

- RESTful API endpoints
- PostgreSQL database for persistent data storage (cloud-ready!)
- CORS enabled for Flutter app integration
- Widget review system for team feedback
- Admin dashboard for managing reviews
- Mark reviews as processed/unprocessed
- Delete reviews functionality
- User and Item management endpoints

## Setup

### Local Development

1. Install dependencies:
```bash
npm install
```

2. Set up PostgreSQL database:
   - Install PostgreSQL locally, or
   - Use a cloud service (Supabase, Neon, etc.)

3. Configure environment variables:
```bash
# Create .env file
DATABASE_URL=postgresql://user:password@localhost:5432/kuba_hub
PORT=3000
NODE_ENV=development
```

4. Initialize the database:
```bash
npm run init-db
```

5. Start the server:
```bash
npm start
```

For development with auto-reload:
```bash
npm run dev
```

The server will run on `http://localhost:3000` by default.

### Production Deployment

See [POSTGRESQL_SETUP_RU.md](POSTGRESQL_SETUP_RU.md) for detailed deployment instructions to Render.com with PostgreSQL.

## API Endpoints

### Reviews (Widget Feedback)

- `POST /api/reviews` - Submit a review for a UI widget
  ```json
  {
    "reviewer_id": 0,
    "widget_name": "kuba_dropdown",
    "comment": "Great design! The colors match our brand perfectly."
  }
  ```
  - `reviewer_id` (required): ID of the reviewer (0-7)
  - `widget_name` (required): Name of the widget being reviewed
  - `comment` (required): Review comment/feedback

- `GET /api/reviews` - Get all reviews (for developers to see feedback)
  - Optional query parameter: `?widget_name=kuba_dropdown` to filter by widget

- `GET /api/reviews/widget/:widget_name` - Get all reviews for a specific widget

- `DELETE /api/reviews/:id` - Delete a review (admin only)

- `PATCH /api/reviews/:id/process` - Mark review as processed/unprocessed (admin only)
  ```json
  {
    "is_processed": true
  }
  ```

### Reviewers

- `GET /api/reviewers` - Get all reviewers (returns `{id, name}` for each reviewer)
- `GET /api/reviewers/:id` - Get a specific reviewer by ID

### Users

- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user by ID
- `POST /api/users` - Create a new user
  ```json
  {
    "name": "John Doe",
    "email": "john@example.com"
  }
  ```
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Items

- `GET /api/items` - Get all items
- `GET /api/items?category=example` - Get items by category
- `GET /api/items/:id` - Get item by ID
- `POST /api/items` - Create a new item
  ```json
  {
    "title": "Item Title",
    "description": "Item description",
    "category": "category-name"
  }
  ```
- `PUT /api/items/:id` - Update item
- `DELETE /api/items/:id` - Delete item

## Admin Dashboard

Access the admin dashboard at `/admin` to manage reviews:
- View all reviews with statistics
- Mark reviews as processed/unprocessed
- Delete reviews
- See pending vs. processed counts

**Example:** `https://your-backend.onrender.com/admin`

See [ADMIN_FEATURES.md](ADMIN_FEATURES.md) for detailed documentation.

## Database

PostgreSQL is used for persistent, reliable data storage in production.

### Tables

- **reviewers**: Stores team member reviewers
  - id (INTEGER PRIMARY KEY)
  - name (TEXT)
  - Pre-seeded with: Lars (0), Nick (1), Leo (2), Hallvard (3), Benjamin (4), Anita (5), Eugene (6), Gest (7)

- **reviews**: Stores widget reviews and comments
  - id (SERIAL PRIMARY KEY)
  - reviewer_id (INTEGER, FOREIGN KEY to reviewers.id)
  - widget_name (TEXT)
  - comment (TEXT)
  - is_processed (BOOLEAN, DEFAULT FALSE) - **NEW!**
  - created_at (TIMESTAMP)

- **users**: Stores user information
  - id (SERIAL PRIMARY KEY)
  - name (TEXT)
  - email (TEXT UNIQUE)
  - created_at (TIMESTAMP)

- **items**: Stores items/components
  - id (SERIAL PRIMARY KEY)
  - title (TEXT)
  - description (TEXT)
  - category (TEXT)
  - created_at (TIMESTAMP)
  - updated_at (TIMESTAMP)

## Environment Variables

Required environment variables:

- `DATABASE_URL`: PostgreSQL connection string (required in production)
  - Example: `postgresql://user:password@host:5432/database`
- `PORT`: Server port (default: 3000)
- `NODE_ENV`: Environment mode (`development` or `production`)

## Project Structure

```
backend/
├── database/
│   └── db.js                    # PostgreSQL connection and initialization
├── routes/
│   ├── admin.js                 # Admin dashboard (NEW!)
│   ├── reviews.js               # Review routes (widget feedback)
│   ├── reviewers.js             # Reviewer routes
│   ├── users.js                 # User routes
│   └── items.js                 # Item routes
├── scripts/
│   └── init-db.js              # Database initialization script
├── server.js                    # Main server file
├── package.json                 # Dependencies
├── README.md                    # This file
├── POSTGRESQL_SETUP_RU.md      # PostgreSQL setup guide (Russian)
├── ADMIN_FEATURES.md            # Admin dashboard documentation
└── ADMIN_SETUP_RU.md           # Admin setup guide (Russian)
```

## Documentation

- **[POSTGRESQL_SETUP_RU.md](POSTGRESQL_SETUP_RU.md)** - Complete guide for PostgreSQL migration (Russian)
- **[ADMIN_FEATURES.md](ADMIN_FEATURES.md)** - Admin dashboard features documentation
- **[ADMIN_SETUP_RU.md](ADMIN_SETUP_RU.md)** - Admin features setup guide (Russian)
- **[README_MIGRATION.md](README_MIGRATION.md)** - Migration summary (Russian)

## Recent Updates

### v2.0 - PostgreSQL Migration & Admin Features
- ✅ Migrated from SQLite to PostgreSQL for persistent storage
- ✅ Added admin dashboard at `/admin`
- ✅ Mark reviews as processed/unprocessed
- ✅ Delete reviews functionality
- ✅ Enhanced statistics (pending vs. processed)
- ✅ Visual indicators for review status
- ✅ Auto-refresh admin dashboard

See [ADMIN_SETUP_RU.md](ADMIN_SETUP_RU.md) for details.

