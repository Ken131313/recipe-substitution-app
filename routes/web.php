<?php

use Illuminate\Support\Facades\Route;
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

    //recommended recipes to diff user
    $user = Auth::user(); 
    Route::get('/recommended-recipes', function (Request $request) {
        $user = $request->user();
        $allergies = array_map('trim', explode(',', $user->allergies ?? ''));

        $query = Recipe::query();

        foreach ($allergies as $allergy){
            if(!empty($allergy)){
                $query->where('ingredients', 'not like', '%'.$allergy.'%');
            }
        }
        $recipes = $query->inRandomOrder()
            ->take(4)
            ->get()
            ->map(function($recipe) {
                return [
                    'id' => $recipe->id,
                    'title' => $recipe->title,
                    'description' => $recipe->description,
                    'image' => $recipe->image_url,
                    'slug' => $recipe->slug
                ];
            });
            
        return response()->json(['recipes' => $recipes]);
    })->name('recommended.recipes');
});

// Route to display a specific recipe
Route::get('/recipes/{slug}', [RecipeController::class, 'show'])->name('recipes.show');
