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
        abort_unless(auth()->check(), 403);
        
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
}
