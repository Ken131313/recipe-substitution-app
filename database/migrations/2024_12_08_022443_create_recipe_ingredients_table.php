<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
{
    Schema::create('recipes_ingredients', function (Blueprint $table) {
        $table->id();
        $table->foreignId('recipe_id')->constrained('recipes')->onDelete('cascade');
        $table->foreignId('ingredient_id')->constrained('ingredients')->onDelete('cascade');
        $table->float('quantity');
        $table->string('unit');
        $table->timestamps();
    });
}

    
};
