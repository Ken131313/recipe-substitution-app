<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Substitution extends Model
{
    use HasFactory;

    protected $fillable = ['recipe_id', 'primary_ingredient', 'substitute', 'compatibility', 'criteria'];

    // Define the relationship with the Recipe model
    public function recipe()
    {
        return $this->belongsTo(Recipe::class);
    }
}