<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Recipe;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class RecipeController extends Controller
{
    public function index()
    {
        $recipes = DB::table('recipes')->select('id', 'title', 'slug')->get();
        return view('index', compact('recipes'));
    }

    public function show($slug)
    {
        $recipe = Recipe::where('slug', $slug)->firstOrFail();

        return view('recipes.show', [
            'recipe' => $recipe,
            'substitutions' => $recipe->substitutions
        ]);
    }

    public function create()
    {
        return view('recipes.create');
    }

    public function store(Request $request)
    {
        // Validate recipe data
        $validated = $request->validate([
            'title' => 'required|string|max:255|unique:recipes,title',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'ingredients' => 'required|string',
            'steps' => 'required|string',
            'substitutions' => 'nullable|array',
            'substitutions.*.primary' => 'nullable|string',
            'substitutions.*.substitute' => 'nullable|string',
            'substitutions.*.compatibility' => 'nullable|integer|min:1|max:100',
            'substitutions.*.criteria' => 'nullable|string',
        ]);

        // Handle image upload
        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('recipe_images', 'public');
        }

        // Convert ingredients and steps to arrays
        $ingredients = explode("\n", str_replace("\r", "", trim($request->ingredients)));
        $steps = explode("\n", str_replace("\r", "", trim($request->steps)));

        // Generate a unique slug
        $slug = Str::slug($validated['title']);
        $originalSlug = $slug;
        $count = 1;
        while (Recipe::where('slug', $slug)->exists()) {
            $slug = "{$originalSlug}-{$count}";
            $count++;
        }

        // Create recipe
        $recipe = Recipe::create([
            'title' => $validated['title'],
            'slug' => $slug,
            'description' => $validated['description'] ?? '',
            'image' => $imagePath,
            'ingredients' => json_encode($ingredients),
            'steps' => json_encode($steps),
            'created_by' => auth()->id() // Ensure user is logged in
        ]);

        // Create substitutions
        if ($request->has('substitutions')) {
            foreach ($request->substitutions as $sub) {
                if (!empty($sub['primary']) && !empty($sub['substitute'])) {
                    $recipe->substitutions()->create([
                        'primary_ingredient' => $sub['primary'],
                        'substitute' => $sub['substitute'],
                        'compatibility' => $sub['compatibility'] ?? 1,
                        'criteria' => $sub['criteria'] ?? ''
                    ]);
                }
            }
        }

        return redirect()->route('recipes.show', $recipe->slug)
            ->with('success', 'Recipe uploaded successfully!');
    }
}
