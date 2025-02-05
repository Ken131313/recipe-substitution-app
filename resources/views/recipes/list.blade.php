<!DOCTYPE html>
@extends('layouts.app') {{-- Assuming you have a layout file --}}

@section('content')
<div class="container">
    <h2 class="mb-4 text-center">All Recipes</h2>
    <div class="row">
        @foreach ($recipes as $recipe)
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
            @if (file_exists(public_path($recipe->image)))
            <img src="{{ asset($recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
            @elseif (file_exists(storage_path('app/public/' . $recipe->image)))
                <img src="{{ asset('storage/' . $recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
            @else
                <img src="{{ asset('img/default-image.jpg') }}" alt="Image not found" class="img-fluid rounded">
            @endif                <div class="card-body">
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
