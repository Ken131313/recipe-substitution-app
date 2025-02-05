<!DOCTYPE html>
@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="row">
        <div class="col-md-6">
        @if (file_exists(public_path($recipe->image)))
            <img src="{{ asset($recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
        @elseif (file_exists(storage_path('app/public/' . $recipe->image)))
            <img src="{{ asset('storage/' . $recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
        @else
            <img src="{{ asset('img/default-image.jpg') }}" alt="Image not found" class="img-fluid rounded">
        @endif
        </div>
        <div class="col-md-6">
            <h1>{{ $recipe->title }}</h1>
            <p class="text-muted">{{ $recipe->description }}</p>

            @if (is_array($recipe->ingredients))
                <h4>Ingredients</h4>
                <ul>
                    @foreach ($recipe->ingredients as $ingredient)
                        <li>{{ $ingredient }}</li>
                    @endforeach
                </ul>
            @elseif (is_string($recipe->ingredients))
                <h4>Ingredients</h4>
                <ul>
                    @foreach (json_decode($recipe->ingredients, true) as $ingredient)
                        <li>{{ $ingredient }}</li>
                    @endforeach
                </ul>
            @endif


            @if (is_array($recipe->steps))
                <h4>Steps</h4>
                <ol>
                    @foreach ($recipe->steps as $step)
                        <li>{{ $step }}</li>
                    @endforeach
                </ol>
            @elseif (is_string($recipe->steps))
                <h4>Steps</h4>
                <ol>
                    @foreach (json_decode($recipe->steps, true) as $step)
                        <li>{{ $step }}</li>
                    @endforeach
                </ol>
            @endif


            {{-- Before: @if ($substitutions && $substitutions->count() > 0) --}}
            @if ($substitutions->isNotEmpty())
                <h4>Substitutions</h4>
                <p>flavor similarity, dietary suitability; 3:well suits , 1:possible to replace</p>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Primary Ingredient</th>
                            <th>Substitute</th>
                            <th>Compatibility</th>
                            <th>Criteria</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($substitutions as $substitution)
                            <tr>
                                <td>{{ $substitution->primary_ingredient }}</td>
                                <td>{{ $substitution->substitute }}</td>
                                <td>{{ $substitution->compatibility }}</td>
                                <td>{{ $substitution->criteria }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            @endif
        </div>
    </div>
</div>
@endsection