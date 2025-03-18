@extends('layouts.app')

@section('content')
<h1>Saved Recipes</h1>
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
                    <div class="recipe-card">
                        <button class = "save-recipe-btn" data-recipe-id="{{ $recipe->id }}">
                            @if(auth()->user() && auth()->user()->savedRecipes->contains($recipe->id))
                                ❤️
                            @else
                                🤍
                            @endif
                        </button>
                    </div>
                    <a href="{{ route('recipes.show', ['slug' => $recipe->slug]) }}" class="btn btn-primary">View Recipe</a>
                </div>

                
            </div>
        </div>
        @endforeach
    </div>
@endsection
