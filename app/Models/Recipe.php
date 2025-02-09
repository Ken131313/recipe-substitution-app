<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'slug', 'description', 'image', 'ingredients', 'steps', 'collections', 'created_by'];

    protected $casts = [
        'ingredients' => 'array',
        'steps' => 'array',
        'collections' => 'array' // Cast collections to an array
    ];

    public function substitutions()
    {
        return $this->hasMany(Substitution::class);
    }
}
