// Call the fetchGenres function when the page loads
window.onload = async function fetchGenres() {
    try {
        const response = await fetch('/genres', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${document.cookie.split('=')[1]}` // Attach the JWT token
            },
        });

        if (!response.ok) {
            console.error('Error fetching genres:', response.statusText);
            return;
        }

        const { genres } = await response.json();

        // Populate the genre checkboxes dynamically
        const genreList = document.getElementById('genreList');
        genres.forEach(genre => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `<input type="checkbox" name="genre" value="${genre.Name}"> ${genre.Name}`;
            genreList.appendChild(listItem);
        });
    } catch (error) {
        console.error('Error fetching genres:', error);
    }
}

function filterGames() {
    // Get the search name
    const searchName = document.querySelector('#searchName').value.trim().toLowerCase();

    // Get all checkboxes with the name "tag"
    const checkboxes = document.querySelectorAll('input[name="tag"]:checked');

    // Extract the values of checked checkboxes
    const selectedTags = Array.from(checkboxes).map(checkbox => checkbox.value);

    // Log the selected tags and search name
    console.log('Search Name:', searchName);
    console.log('Selected Tags:', selectedTags);

    // Your logic to filter games based on searchName and selectedTags
    // For now, let's just log a message
    console.log('Filtering games...');
}
