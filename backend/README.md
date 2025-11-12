# Kuba UI Hub Backend API

A simple REST API backend for the Kuba UI Hub Flutter application, built with Node.js, Express, and SQLite.

## Features

- RESTful API endpoints
- SQLite database for data persistence
- CORS enabled for Flutter app integration
- Widget review system for team feedback
- User and Item management endpoints

## Setup

1. Install dependencies:
```bash
npm install
```

2. Initialize the database:
```bash
npm run init-db
```

3. Start the server:
```bash
npm start
```

For development with auto-reload:
```bash
npm run dev
```

The server will run on `http://localhost:3000` by default.

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

## Database

The database file (`kuba_hub.db`) is stored in the `database/` directory. SQLite is used for simplicity and doesn't require a separate database server.

### Tables

- **reviewers**: Stores team member reviewers
  - id (INTEGER PRIMARY KEY)
  - name (TEXT)
  - Pre-seeded with: Lars (0), Nick (1), Leo (2), Hallvard (3), Benjamin (4), Anita (5), Eugene (6), Gest (7)

- **reviews**: Stores widget reviews and comments
  - id (INTEGER PRIMARY KEY AUTOINCREMENT)
  - reviewer_id (INTEGER, FOREIGN KEY to reviewers.id)
  - widget_name (TEXT)
  - comment (TEXT)
  - created_at (DATETIME)

- **users**: Stores user information
  - id (INTEGER PRIMARY KEY)
  - name (TEXT)
  - email (TEXT UNIQUE)
  - created_at (DATETIME)

- **items**: Stores items/components
  - id (INTEGER PRIMARY KEY)
  - title (TEXT)
  - description (TEXT)
  - category (TEXT)
  - created_at (DATETIME)
  - updated_at (DATETIME)

## Environment Variables

You can set the following environment variables:

- `PORT`: Server port (default: 3000)

## Project Structure

```
backend/
├── database/
│   ├── db.js          # Database connection and initialization
│   └── kuba_hub.db    # SQLite database file (created on first run)
├── routes/
│   ├── reviews.js     # Review routes (widget feedback)
│   ├── reviewers.js    # Reviewer routes
│   ├── users.js       # User routes
│   └── items.js       # Item routes
├── scripts/
│   └── init-db.js    # Database initialization script
├── server.js          # Main server file
├── package.json       # Dependencies
└── README.md         # This file
```

