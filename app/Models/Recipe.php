<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'description', 'image', 'ingredients', 'steps', 'created_by'];

    protected $casts = [
        'ingredients' => 'array',
        'steps' => 'array'
    ];
    

    public function substitutions()
    {
        return $this->hasMany(Substitution::class);
    }
}