<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('users', function (Blueprint $table){
            $table->string('dietary_preferences')->nullable();
            $table->string('allergies')->nullable();
            $table->string('cooking_skill')->nullable();
        });
    }

    public function down()
    {
        Schema::table('users', function (Bluprint $table){
            $table->dropColumn(['dietary_preferences','allergies','cooking_skill'])->nullable();
        });
    }
};
