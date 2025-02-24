<!DOCTYPE html>
@extends('layouts.app')

@section('content')
<div class="container py-5">
    <h2>Upload New Recipe</h2>
    <form action="{{ route('recipes.store') }}" method="POST" enctype="multipart/form-data">
        @csrf

        <!-- Recipe Details -->
        <div class="mb-3">
            <label for="title" class="form-label">Recipe Title</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Recipe Image</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
        </div>

        <!-- Ingredients -->
        <div class="mb-3">
            <label class="form-label">Ingredients (one per line)</label>
            <textarea class="form-control" name="ingredients" rows="5" 
                placeholder="Enter each ingredient on a new line" required></textarea>
        </div>

        <!-- Steps -->
        <div class="mb-3">
            <label class="form-label">Cooking Steps (one per line)</label>
            <textarea class="form-control" name="steps" rows="5" 
                placeholder="Enter each step on a new line" required></textarea>
        </div>
        
        <!-- Substitutions -->
        <div class="mb-3">
            <h4>Ingredient Substitutions</h4>
            <div id="substitutions-container">
                <div class="substitution-group mb-3">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="substitutions[0][primary]" 
                                placeholder="Primary Ingredient">
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control" name="substitutions[0][substitute]" 
                                placeholder="Substitute">
                        </div>
                        <div class="col-md-2">
                            <input type="number" class="form-control" name="substitutions[0][compatibility]" 
                                placeholder="Compatibility (1-3)" min="1" max="3">
                        </div>
                        <div class="col-md-4">
                            <input type="text" class="form-control" name="substitutions[0][criteria]" 
                                placeholder="Substitution Criteria">
                        </div>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-secondary mt-2" onclick="addSubstitutionField()">
                Add Another Substitution
            </button>
        </div>

        <!--collection selection-->
        <div class="mb-3">
            <label class="form-label">Select its catergories:</label>
            <div class="btn-group" role="group" aria-label="Collection selection">
                <!--Vegan-->
                <input type="checkbox" class="btn-check" id="collectionVegan" autocomplete="off" name="collections[]" value="Vegan">
                <label class="btn btn-outline-primary" for="collectionVegan">Vegan </label>

                <!--gluten free-->
                <input type="checkbox" class="btn-check" id="collectionGlutenFree" autocomplete="off" name="collections[]" value="Gluten Free">
                <label class="btn btn-outline-primary" for="collectionGlutenFree">Gluten Free </label>

                <!--High in protein-->
                <input type="checkbox" class="btn-check" id="collectionHignProtein" autocomplete="off" name="collections[]" value="High in Protein">
                <label class="btn btn-outline-primary" for="collectionHignProtein">High in Protein </label>

                <!--Meat-->
                <input type="checkbox" class="btn-check" id="collectionMeat" autocomplete="off" name="collections[]" value="Meat">
                <label class="btn btn-outline-primary" for="collectionMeat">Meat </label>

                <!--Seafood-->
                <input type="checkbox" class="btn-check" id="collectionSeafood" autocomplete="off" name="collections[]" value="Seafood">
                <label class="btn btn-outline-primary" for="collectionSeafood">Seafood </label>
            </div>
        </div>
                
        <button type="submit" class="btn btn-primary">Submit Recipe</button>
    </form>
</div>

<script>
let subCount = 1;
function addSubstitutionField() {
    const container = document.getElementById('substitutions-container');
    const newGroup = document.createElement('div');
    newGroup.className = 'substitution-group mb-3';
    newGroup.innerHTML = `
        <div class="row g-3">
            <div class="col-md-3">
                <input type="text" class="form-control" name="substitutions[${subCount}][primary]" 
                    placeholder="Primary Ingredient">
            </div>
            <div class="col-md-3">
                <input type="text" class="form-control" name="substitutions[${subCount}][substitute]" 
                    placeholder="Substitute">
            </div>
            <div class="col-md-2">
                <input type="number" class="form-control" name="substitutions[${subCount}][compatibility]" 
                    placeholder="Compatibility (1-3)" min="1" max="3">
            </div>
            <div class="col-md-4">
                <input type="text" class="form-control" name="substitutions[${subCount}][criteria]" 
                    placeholder="Substitution Criteria">
            </div>
        </div>
    `;
    container.appendChild(newGroup);
    subCount++;
}
</script>
@if($errors->any())
    <div class="alert alert-danger">
        <ul>
            @foreach($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif
@endsection