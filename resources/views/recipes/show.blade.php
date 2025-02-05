<!DOCTYPE html>
@extends('layouts.app')

@section('content')
<div class="container py-5">
    <div class="row">
        <div class="col-md-6">
            <img src="{{ asset('storage/' . $recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
        </div>
        <div class="col-md-6">
            <h1>{{ $recipe->title }}</h1>
            <p class="text-muted">{{ $recipe->description }}</p>

            @if ($recipe->ingredients)
                <h4>Ingredients</h4>
                <ul>
                    @foreach (json_decode($recipe->ingredients, true) as $ingredient)
                        <li>{{ $ingredient }}</li>
                    @endforeach
                </ul>
            @endif

            @if ($recipe->steps)
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