function getQueryParams() {
    const params = {};
    const queryString = window.location.search.substring(1);
    const regex = /([^&=]+)=([^&]*)/g;
    let m;
    while ((m = regex.exec(queryString))) {
      params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
    }
    return params;
  }
  
  async function fetchEventData(eventId) {
    console.log('Fetching event data for ID:', eventId);
    try {
      const response = await fetch(`/api/event?id=${eventId}`);
      console.log('Response status:', response.status);
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      const event = await response.json();
      console.log('Event data:', event);
      document.getElementById('event-name').textContent = event.event_name;
      document.getElementById('event-location').textContent = event.location;
      document.getElementById('event-date').textContent = event.date;
      document.getElementById('event-time').textContent = event.time;
      document.getElementById('event-description').textContent = event.description;
      //document.getElementById('event-category').textContent = event.category;
      document.getElementById('event-username').textContent = event.username;
      document.getElementById('event-image').src = "/" + event.image_path;
      console.log(event.image_path)
    } catch (error) {
      console.error('Failed to fetch event data:', error);
    }
  }
  
  document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM fully loaded and parsed');
    const params = getQueryParams();
    const eventId = params.id;
    console.log('Query params:', params);
    if (eventId) {
      fetchEventData(eventId);
    } else {
      console.error('No event ID provided in the URL');
    }
  });
  