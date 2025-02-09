@extends('layouts.app')

@section('content')
<div class="container">
    <h2 class="mb-4 text-center">All Recipes</h2>

    <!-- Filters Section -->
    <form method="GET" action="{{ route('recipes.list') }}">
        <div class="dropdown">
            <button class="btn dropdown-toggle" type="button" id="dropdownCollection" data-bs-toggle="dropdown" aria-expanded="false">
                By Collection
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="{{ route('recipes.list', ['collections' => 'Vegan']) }}">Vegan</a></li>
                <li><a class="dropdown-item" href="{{ route('recipes.list', ['collections' => 'Gluten Free']) }}">Gluten Free</a></li>
                <li><a class="dropdown-item" href="{{ route('recipes.list', ['collections' => 'High in Protein']) }}">High in Protein</a></li>
                <li><a class="dropdown-item" href="{{ route('recipes.list', ['collections' => 'Meat']) }}">Meat</a></li>
                <li><a class="dropdown-item" href="{{ route('recipes.list', ['collections' => 'Seafood']) }}">Seafood</a></li>
            </ul>
        </div>
    </form>

    <!-- Selected Filters -->
    <div id="selectedFilters" class="mb-3">
        <strong>Selected Filters:</strong>
        <span id="filterDisplay"></span>
        <button class="btn btn-sm btn-danger d-none" id="clearFilters" data-url="{{ route('recipes.list')}}">Clear Filters</button>
    </div>

    <!-- Recipe List -->
    <div class="row" id="recipeList">
        @foreach ($recipes as $recipe)
        <div class="col-md-4 recipe-item" data-collection="{{ $recipe->collection }}">
            <div class="card mb-4 shadow-sm">
                @if (file_exists(public_path($recipe->image)))
                <img src="{{ asset($recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
                @elseif (file_exists(storage_path('app/public/' . $recipe->image)))
                <img src="{{ asset('storage/' . $recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
                @else
                <img src="{{ asset('img/default-image.jpg') }}" alt="Image not found" class="img-fluid rounded">
                @endif
                
                <div class="card-body">
                    <h5 class="card-title">
                        <a href="{{ route('recipes.show', ['slug' => $recipe->slug]) }}" class="text-decoration-none">
                            {{ $recipe->title }}
                        </a>
                    </h5>
                    <a href="{{ route('recipes.show', ['slug' => $recipe->slug]) }}" class="btn btn-primary">View Recipe</a>
                </div>
            </div>
        </div>
        @endforeach
    </div>
</div>
@endsection

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Get URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const collection = urlParams.get('collections');
    
    // Get elements from the page
    const filterDisplay = document.getElementById('filterDisplay');
    const clearFiltersBtn = document.getElementById('clearFilters');
    
    // If a collection filter exists, display it and show the Clear Filters button
    if (collection) {
        filterDisplay.textContent = collection;
        clearFiltersBtn.classList.remove('d-none');
    }
    
    // Listen for the Clear Filters button click
    clearFiltersBtn.addEventListener('click', function() {
        const url=clearFiltersBtn.getAttribute('data-url');
        // Redirect to the recipes list without any query parameters (clearing the filter)
        window.location.href = url;
    });
});
</script>
