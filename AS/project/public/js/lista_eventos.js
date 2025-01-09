let eventCounter = 0; // Initialize event counter
let currentUrl = '/api/upcoming-events'; // Default URL for upcoming events

// Function to display an event in the specified container
function displayEvent(event, container) {
    const eventDiv = document.createElement('div');
    eventDiv.classList.add('event');

    const eventDate = new Date(event.date + 'T' + event.time);
    const formattedDate = eventDate.toLocaleDateString();
    const formattedTime = eventDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    const weekDay = getDayOfWeek(event.date);
    const image_path = event.image_path;


    eventDiv.innerHTML = `
        <div>
            <a href="evento?id=${event.id}" style="text-decoration:none; color:black;">
                <h2 class="event-info">${event.event_name}</h2>
                <p class="event-info"><img src="/images/calendar-symbol.png" alt="Calendar Icon" class="small-img"> <strong>${formattedDate}</strong></p>
                <p class="event-info"><img src="/images/clock.png" alt="Clock Icon" class="small-img"> <strong>${weekDay} - ${formattedTime}h</strong></p>
                <p class="event-info"><img src="/images/location-pin.png" alt="Location Icon" class="small-img"> <strong>${event.location}</strong></p>
                <img class="event-image" src="${image_path}" alt="${image_path}">
            </a>
        </div>
    `;
    
    container.appendChild(eventDiv);
    eventCounter++; // Increment event counter
}

function listEvents(url) {
    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch json file');
            }
            return response.json();
        })
        .then(data => {
            const eventsContainer = document.getElementById('eventsContainer');
            const loadMoreButton = document.getElementById('loadMoreButton');

            // Clear previous events
            eventsContainer.innerHTML = '';
            eventCounter = 0;

            // Display "Load More" button if there are more than 9 events
            if (data.length > 9) {
                loadMoreButton.style.display = 'block';
            } else {
                loadMoreButton.style.display = 'none';
            }

            data.forEach((event, index) => {
                // Display up to 9 events initially
                if (eventCounter < 9) {
                    displayEvent(event, eventsContainer);
                }
            });

            console.log('JSON file found and loaded successfully.');
        })
        .catch(error => console.error('Error fetching events:', error));
}

// Function to handle "Load More" button click
function loadMoreEvents() {
    fetch(currentUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to fetch json file');
            }
            return response.json();
        })
        .then(data => {
            const eventsContainer = document.getElementById('eventsContainer');
            const loadMoreButton = document.getElementById('loadMoreButton');

            // Loop through events starting from the current event counter
            for (let i = eventCounter; i < eventCounter + 9 && i < data.length; i++) {
                const event = data[i];
                displayEvent(event, eventsContainer);
            }

            // Increment event counter
            eventCounter += 9;

            // Hide "Load More" button if all events are displayed
            if (eventCounter >= data.length) {
                loadMoreButton.style.display = 'none';
            }

            console.log('Additional events loaded successfully.');
        })
        .catch(error => console.error('Error fetching events:', error));
}

function getMonthInitial(dateString) {
    // Split the date string by '-'
    const parts = dateString.split('-');
    
    // Extract the month part (index 1) and convert it to a number
    const month = parseInt(parts[1], 10);

    // Define an array with month names
    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    // Return the first three letters of the month name
    return monthNames[month - 1].substr(0, 3); // Adjust index to 0-based
}

function getDayOfWeek(dateString) {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    
    // Create a new Date object with the given date string
    const date = new Date(dateString);

    // Get the day of the week (0-6)
    const dayOfWeekIndex = date.getDay();

    // Return the first three letters of the day of the week
    return daysOfWeek[dayOfWeekIndex];
}

document.addEventListener('DOMContentLoaded', function() {
    const eventToggle = document.getElementById('eventToggle');
    eventToggle.addEventListener('change', function() {
        currentUrl = this.checked ? '/api/past-events' : '/api/upcoming-events';
        listEvents(currentUrl);
    });

    // Initial load
    listEvents(currentUrl);

    const loadMoreButton = document.getElementById('loadMoreButton');
    loadMoreButton.addEventListener('click', loadMoreEvents);
});
