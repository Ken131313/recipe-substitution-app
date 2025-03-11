@extends('layouts.app')

@section('content')
<div class="container">
    <h1>{{ $recipe->title }}</h1>
    <img src="{{ asset($recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
    <p>{{ $recipe->description }}</p>
    <p><strong>Ingredients:</strong> {{ $recipe->ingredients }}</p>
</div>
@endsection
