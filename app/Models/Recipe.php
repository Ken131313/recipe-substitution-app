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

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function getRouteKeyName()
    {
        return 'slug'; // Ensure you have a 'slug' column in your database
    }
    public function getImageUrlAttribute()
    {
        if (file_exists(public_path($this->image))) {
            return asset($this->image);
        }
        
        if (file_exists(storage_path('app/public/' . $this->image))) {
            return asset('storage/' . $this->image);
        }
        
        return asset('img/default-image.jpg');
    }
    protected $fullText = ['ingredients'];

    public function scopeWithoutAllergies($query, $allergies)
    {
        foreach ($allergies as $allergy) {
            $query->whereRaw(
                "MATCH(ingredients) AGAINST(? IN BOOLEAN MODE)",
                ["-{$allergy}"]
            );
        }
    }
}
