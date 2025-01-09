const fs = require('fs');
const sqlite3 = require('sqlite3').verbose();

// Connect to the database
const db = new sqlite3.Database('../db/events.db', (err) => {
  if (err) {
    return console.error(err.message);
  }
  console.log('Connected to the SQLite database.');
});

// Function to insert or replace an event into the database
const insertEvent = (event) => {
  const sql = `
    INSERT OR REPLACE INTO events (id, username, date, time, event_name, description, location, category, image_path)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const params = [
    event.id,
    event.username,
    event.date,
    event.time,
    event.event_name,
    event.description,
    event.location,
    event.category,
    event.image_path
  ];

  db.run(sql, params, function(err) {
    if (err) {
      return console.error(err.message);
    }
    console.log(`A row has been inserted or replaced with rowid ${this.lastID}`);
  });
};

// Read the JSON file
fs.readFile('events.json', 'utf8', (err, data) => {
  if (err) {
    return console.error(err);
  }

  // Parse the JSON data
  const events = JSON.parse(data);

  // Insert each event into the database
  events.forEach(insertEvent);
});

// Close the database connection
process.on('exit', (code) => {
  db.close((err) => {
    if (err) {
      return console.error(err.message);
    }
    console.log('Closed the database connection.');
  });
});

process.on('SIGINT', () => {
  process.exit();
});

process.on('SIGTERM', () => {
  process.exit();
});

process.on('uncaughtException', (err) => {
  console.error('Uncaught exception:', err);
  process.exit(1);
});
