<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::create('substitutions', function (Blueprint $table) {
        $table->id();
        $table->foreignId('recipe_id')->constrained()->onDelete('cascade'); // Links to the recipe
        $table->string('primary_ingredient'); // Primary ingredient
        $table->string('substitute'); // Substitute ingredient
        $table->integer('compatibility'); // Compatibility score (e.g., 1 to 5)
        $table->text('criteria'); // Criteria for substitution
        $table->timestamps();
    });
}
};
