<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable;

    protected $fillable = [
        'username',
        'email',
        'password',
        'allergies',
        'cooking_skill',
        'role'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];
   
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
    
    public function savedRecipes()
    {
        return $this->belongsToMany(Recipe::class, 'saved_recipes')->withTimestamps();
    }

}
