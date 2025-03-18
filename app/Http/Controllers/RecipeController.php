<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Recipe;
use App\Models\SavedRecipe;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class RecipeController extends Controller
{
    public function index()
    {
        $recipes = DB::table('recipes')->select('id', 'title', 'slug')->get();
        
        $userAllergies = Auth::check() ? (Auth::user()->allergies ?? []) : [];
        if (is_string($userAllergies)) {
            $userAllergies = explode(',', strtolower($userAllergies));
        } elseif (!is_array($userAllergies)) {
            $userAllergies = [];
        }
        

        $recommendedRecipes = Recipe::inRandomOrder()->get()->filter(function ($recipe) use ($userAllergies){
            $decodedIngredients = json_decode($recipe->ingredients, true);

                if (is_string($decodedIngredients)) {
                    $decodedIngredients = json_decode($decodedIngredients, true);
                }

                if(!is_array($decodedIngredients)){
                    return true;
                }

                $ingredients = array_map('strtolower', $decodedIngredients);

                foreach ($userAllergies as $allergen) {
                    if (in_array(trim($allergen), $ingredients)) {
                        return false;
                    }
                }
                return true;
            })->take(3);

            return view('index', compact('recommendedRecipes'));
        
    }

    public function show($slug)
    {
        $recipe = Recipe::where('slug', $slug)->firstOrFail();
        $substitutions = $recipe->substitutions;

        return view('recipes.show', [
            'recipe' => $recipe,
            'substitutions' => $recipe->substitutions
        ]);
    }

    

    public function creation()
    {
        // Fetch distinct collections from the database (assuming collection is a column in recipes)
        $collections = \DB::table('recipes')
            ->select('collections')
            ->whereNotNull('collections')
            ->distinct()
            ->pluck('collections');
        
        return view('recipes.creation', compact('collections'));
    }


    public function store(Request $request)
    {
        abort_unless(auth()->check(), 403);
        
        $validated = $request->validate([
            'title' => 'required|string|max:255|unique:recipes,title',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'ingredients' => 'required|string',
            'steps' => 'required|string',
            'collections' => 'nullable|array',
            'substitutions' => 'nullable|array',
            'substitutions.*.primary' => 'nullable|string',
            'substitutions.*.substitute' => 'nullable|string',
            'substitutions.*.compatibility' => 'nullable|integer|min:1|max:100',
            'substitutions.*.criteria' => 'nullable|string',
        ]);

        try {
            // Generate slug first
            $slug = Str::slug($validated['title']);
            $counter = 1;
            while (Recipe::where('slug', $slug)->exists()) {
                $slug = Str::slug($validated['title'] . '-' . $counter++);
            }

            // Create WITHOUT transaction
            $recipe = Recipe::create([
                'title' => $validated['title'],
                'slug' => $slug,
                'description' => $validated['description'] ?? '',
                'image' => $request->hasFile('image') 
                    ? $request->file('image')->store('recipe_images', 'public')
                    : null,
                'ingredients' => json_encode(
                    array_filter(
                        explode("\n", str_replace("\r", "", $request->ingredients))
                    )
                ),
                'steps' => json_encode(
                    array_filter(
                        explode("\n", str_replace("\r", "", $request->steps))
                    )
                ),
                'collections' => $validated['collections'] ?? [], 
                'created_by' => auth()->id()
            ]);

            // Create substitutions separately
            collect($request->substitutions ?? [])
                ->filter(fn($sub) => !empty($sub['primary']) && !empty($sub['substitute']))
                ->each(fn($sub) => $recipe->substitutions()->create([
                    'primary_ingredient' => $sub['primary'],
                    'substitute' => $sub['substitute'],
                    'compatibility' => $sub['compatibility'] ?? 1,
                    'criteria' => $sub['criteria'] ?? ''
                ]));

            return redirect()->route('recipes.show', $recipe->slug);

        } catch (\Exception $e) {
            logger()->error('Recipe Creation Failed:', ['error' => $e->getMessage()]);
            return back()->withErrors('Error: ' . $e->getMessage());
        }
    }

    public function list(Request $request)
    {
        $query = Recipe::query();

        if ($request->has('collections')) {
            $selectedCollections = is_array($request->collections) ? $request->collections : [$request->collections];

            $query->where(function ($q) use ($selectedCollections) {
                foreach ($selectedCollections as $collection) {
                    $q->orWhereJsonContains('collections', $collection);
                }
            });
        }

        $recipes = $query->get();
        return view('recipes.list', compact('recipes'));
    }

    public function savedRecipes()
    {
        $recipes = auth()->user()->savedRecipes;
        return view('recipes.saved', compact('recipes'));
    }

    public function toggleSave($recipeId)
    {
        if (!Auth::check()) {
            return redirect()->route('login')->with('error', 'Please log in to save recipes.');
        }

        $user = Auth::user();
        $saved = SavedRecipe::where('user_id', $user->id)->where('recipe_id', $recipeId)->first();

        if ($saved) {
            $saved->delete();
            return redirect()->back()->with('success', 'Recipe removed from favorites.');
        } else {
            SavedRecipe::create([
                'user_id' => $user->id,
                'recipe_id' => $recipeId,
            ]);
            return redirect()->back()->with('success', 'Recipe added to favorites.');
        }
    }


}
