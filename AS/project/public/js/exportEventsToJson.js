const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');

// Connect to the SQLite database
const db = new sqlite3.Database('../db/events.db', (err) => {
  if (err) {
    return console.error(err.message);
  }
  console.log('Connected to the SQLite database.');
});

// Function to export events to JSON file
function exportEventsToJson() {
  const sql = 'SELECT * FROM events';
  
  db.all(sql, [], (err, rows) => {
    if (err) {
      throw err;
    }

    // Convert the rows to JSON
    const json = JSON.stringify(rows, null, 2);

    // Write JSON data to a file
    fs.writeFile('events.json', json, (err) => {
      if (err) {
        throw err;
      }
      console.log('Events have been written to events.json');
      
      // Close the database connection
      db.close((err) => {
        if (err) {
          return console.error(err.message);
        }
        console.log('Closed the database connection.');
      });
    });
  });
}

// Call the function to export events
exportEventsToJson();
