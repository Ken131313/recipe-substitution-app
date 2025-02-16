<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Comment;
use App\Models\Recipe;

class CommentController extends Controller
{
    // Ensure that only authenticated users can store comments
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function store(Request $request, Recipe $recipe)
    {
        $validated = $request->validate([
            'body' => 'required|string|max:1000',
        ]);

        $comment = Comment::create([
            'recipe_id' => $recipe->id,
            'user_id'   => auth()->id(),
            'body'      => $validated['body'],
        ]);

        return redirect()->route('recipes.show', $recipe->slug)
                         ->with('success', 'Comment added successfully!');
    }
}
