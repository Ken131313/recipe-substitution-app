document.addEventListener('DOMContentLoaded', function(){
    //get url parameter
    const urlParams = new URLSearchParams(window.location.search);
    const allergies = urlParams.get('allergies') ? urlParams.get('allergies').split(',') : [];

    const recipeItems = document.querySelectorAll('.recipe-item');

    recipeItems.forEach(item => {
        const ingredients = item.getAttribute('data-ingredients');
        let hide = false;
        allergies.forEach(allergy => {
            if (ingredients.toLowerCase().includes(allergy.toLowerCase())) {
                hide = true;
            }
        });

        if (hide) {
            item.style.display = 'none';
        }
    });
});