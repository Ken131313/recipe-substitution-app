<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class IngredientSubstitution extends Model
{
    use HasFactory;

    protected $table = 'substitutions';
    protected $fillable = [
        'recipe_id', 'primary_ingredient', 
        'substitute', 'compatibility', 'criteria'
    ];

    public function recipe()
    {
        return $this->belongsTo(Recipe::class);
    }
}
