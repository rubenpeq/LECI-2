const fs = require('fs');

// Function to generate a random event
function generateRandomEvent(id) {
    const eventNames = [
        'Congresso de Tecnologia', 'Caminhada Solidária', 'Festival de Jazz',
        'Feira do Livro', 'Palestra de Empreendedorismo', 'Desfile de Carnaval', 'Concerto de Rock',
        'Aula de Surf', 'Exposição de História Local', 'Workshop de Fotografia', 'Feira de Artesanato',
        'Sessão de Cinema ao Ar Livre', 'Aula de Dança', 'Exposição de Arte Contemporânea'
    ];

    const locations = [
        'Lisbon', 'Porto', 'Braga', 'Coimbra', 'Aveiro', 'Faro', 'Funchal',
        'Évora', 'Guimarães', 'Viseu'
    ];

    const usernames = [
        'pedro', 'david', 'simao', 'ruben'
    ];

    const categories = [
        'Festival', 'Conference', 'Charity', 'Music', 'Book Fair', 'Workshop', 'Parade', 'Concert',
        'Sport', 'Exhibition', 'Art', 'Cinema', 'Dance', 'Craft', 'Education'
    ];

    const descriptions = [
        'Join us for an amazing experience.', 'A must-attend event!', 'Fun for the whole family.', 
        'An educational event.', 'Don’t miss out!', 'A unique opportunity to learn and grow.'
    ];

    const getRandomDate = () => {
        const now = new Date();
        const start = new Date(now.getTime() - (2 * 365 * 24 * 60 * 60 * 1000)); // 2 years in the past
        const end = new Date(now.getTime() + (365 * 24 * 60 * 60 * 1000)); // 1 year in the future
        return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
    };

    const eventName = eventNames[Math.floor(Math.random() * eventNames.length)];
    const location = locations[Math.floor(Math.random() * locations.length)];
    const username = usernames[Math.floor(Math.random() * usernames.length)];
    const category = categories[Math.floor(Math.random() * categories.length)];
    const description = descriptions[Math.floor(Math.random() * descriptions.length)];
    const date = getRandomDate().toISOString().split('T')[0];
    const hour = Math.floor(Math.random() * 15 + 8); // Random hour value
    const minutes = ['00', '30']; // Array of possible minute values
    const minute = minutes[Math.floor(Math.random() * minutes.length)]; // Randomly select a minute from the array
    const time = `${hour.toString().padStart(2, '0')}:${minute}`;

    return {
        id: id,
        username: username,
        date: date,
        time: time,
        event_name: eventName,
        description: description,
        location: location,
        category: category,
        image_path: `events-images/${eventName.replace(/\s+/g, '-').toLowerCase()}.jpg`
    };
}

// Generate random events
const numEvents = 75;
const events = [];
for (let i = 0; i < numEvents; i++) {
    events.push(generateRandomEvent(i + 1)); // Start IDs from 1
}

// Write events to JSON file
fs.writeFile('events.json', JSON.stringify(events, null, 2), (err) => {
    if (err) throw err;
    console.log(`${numEvents} random events have been written to events.json`);
});
