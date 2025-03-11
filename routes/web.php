<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\RecipeController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\CommentController;
use App\Models\Recipe;
// Route to display the homepage 
Route::get('/', [RecipeController::class, 'index'])->name('index');
// About Us page
Route::get('/about', [PageController::class, 'about'])->name('about');
Route::get('/recipes', [RecipeController::class, 'list'])->name('recipes.list');

// Authentication routes
Route::get('/login', [AuthController::class, 'showLoginForm'])->name('login');
Route::post('/login', [AuthController::class, 'login'])->name('login.post');
Route::get('/register', [AuthController::class, 'showRegisterForm'])->name('register');
Route::post('/register', [AuthController::class, 'register'])->name('register.post');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

Route::middleware('auth')->group(function () {
    Route::get('/recipes/creation', [RecipeController::class, 'creation'])->name('recipes.creation');
    Route::post('/recipes', [RecipeController::class, 'store'])->name('recipes.store');
    Route::post('/recipes/{recipe}/comments', [CommentController::class, 'store'])
        ->name('comments.store');

    Route::get('/recommended-recipe/{id}', [RecipeController::class, 'recommendedRecipe'])
        ->name('recommended.recipe.show')
        ->middleware('auth');
    
});

// Route to display a specific recipe
Route::get('/recipes/{slug}', [RecipeController::class, 'show'])->name('recipes.show');
