<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
{
    Schema::create('ingredient_substitutions', function (Blueprint $table) {
        $table->id();
        $table->foreignId('ingredient_id')->constrained('ingredients')->onDelete('cascade');
        $table->foreignId('substitute_ingredient_id')->constrained('ingredients')->onDelete('cascade');
        $table->float('edge_weight'); // edge weight (1-3)
        $table->text('criteria'); // criteria
        $table->timestamps();
    });
}

};
