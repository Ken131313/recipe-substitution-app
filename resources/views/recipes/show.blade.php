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
                        <li>
                            {{ $ingredient }}
                            <!-- Button to trigger the modal -->
                            <button type="button" class="btn btn-link btn-sm substitution-btn" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#substitutionModal" 
                                    data-ingredient="{{ $ingredient }}">
                                Show Substitutions
                            </button>
                        </li>
                    @endforeach
                </ul>
            @elseif (is_string($recipe->ingredients))
                <h4>Ingredients</h4>
                <ul>
                    @foreach (json_decode($recipe->ingredients, true) as $ingredient)
                        <li>
                            {{ $ingredient }}
                            <!-- Button to trigger the modal -->
                            <button type="button" class="btn btn-link btn-sm substitution-btn" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#substitutionModal" 
                                    data-ingredient="{{ $ingredient }}">
                                Show Substitutions
                            </button>
                        </li>
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

            
        </div>
    </div>
</div>

<!-- Modal Markup: Place this here, before the endsection -->
<div class="modal fade" id="substitutionModal" tabindex="-1" aria-labelledby="substitutionModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="substitutionModalLabel">Substitution Recommendations</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="modalSubstitutionContent">
          Loading...
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Include JavaScript to populate the modal dynamically -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    // Pre-load all substitutions as a JavaScript variable
    var allSubstitutions = {!! $substitutions->toJson() !!};

    // Listen for the modal's show event
    var substitutionModal = document.getElementById('substitutionModal');
    substitutionModal.addEventListener('show.bs.modal', function (event) {
        var button = event.relatedTarget; // Button that triggered the modal
        var ingredient = button.getAttribute('data-ingredient'); // Get ingredient name

        // Update the modal title with the selected ingredient
        var modalTitle = substitutionModal.querySelector('.modal-title');
        modalTitle.textContent = 'Substitutions for: ' + ingredient;

        // Filter the substitutions for this ingredient
        var filteredSubs = allSubstitutions.filter(function (sub) {
            return sub.primary_ingredient === ingredient;
        });

        // Prepare the HTML to display the substitutions
        var modalContent = substitutionModal.querySelector('#modalSubstitutionContent');
        if (filteredSubs.length > 0) {
            var contentHtml = '<ul class="list-group">';
            filteredSubs.forEach(function (sub) {
                contentHtml += '<li class="list-group-item">';
                contentHtml += '<strong>' + sub.substitute + '</strong> ';
                contentHtml += '<small class="text-muted">Compatibility: ' + sub.compatibility + ' (3:well suits;1:possible to replace)</small>';
                contentHtml += '<br><em>' + sub.criteria + '</em>';
                contentHtml += '</li>';
            });
            contentHtml += '</ul>';
            modalContent.innerHTML = contentHtml;
        } else {
            modalContent.innerHTML = '<p>No substitutions available for this ingredient.</p>';
        }
    });
});
</script>
@endsection
