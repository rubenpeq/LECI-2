-- Drop the existing table
DROP TABLE IF EXISTS events;

-- Recreate the table with auto-incrementing primary key
CREATE TABLE events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    event_name TEXT NOT NULL,
    description TEXT,
    location TEXT NOT NULL,
    category TEXT,
    image_path TEXT
);

-- Reset the sequence for the primary key
DELETE FROM sqlite_sequence WHERE name = 'events';