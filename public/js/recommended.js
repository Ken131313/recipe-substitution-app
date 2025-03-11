document.addEventListener('DOMContentLoaded', function() {
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    const csrfToken = csrfTokenMeta ? csrfTokenMeta.content : '';

    fetch('/recommended-recipes', {  
        headers: {
            'Accept': 'application/json',
            'X-CSRF-TOKEN': csrfToken
        },
        credentials: 'include'
    })
    .then(response => {
        if (response.status === 401) {
            console.log('User not authenticated, hiding recommendations');
            document.querySelector('.recommended-recipes').style.display = 'none';
            return;
        }
        return response.json();
    })
    .then(data => {
        if (!data?.recipes) return;
        
        const recipesContainer = document.querySelector('.recipes-container');
        recipesContainer.innerHTML = '';
        
        data.recipes.forEach(recipe => {
            const card = document.createElement('div');
            card.className = 'recipe-card';
            card.innerHTML = `
                <img src="${recipe.image}" alt="${recipe.title}">
                <h3>${recipe.title}</h3>
                <p>${recipe.description}</p>
                <a href="/recipes/${recipe.slug}" class="btn">View Recipe</a>
            `;
            recipesContainer.appendChild(card);
        });
        if (data.recipes.length === 0) {
            recipesContainer.innerHTML = `
                <div class="empty-state">
                    <p>No recommendations found based on your preferences</p>
                </div>
            `;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        document.querySelector('.recommended-recipes').style.display = 'none';
    });
});