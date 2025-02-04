<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up()
{
    Schema::create('users', function (Blueprint $table) {
        $table->id(); // Primary key
        $table->string('username')->unique();
        $table->string('email')->unique();
        $table->string('password');
        $table->string('role')->default('user'); // e.g., admin, guest
        $table->timestamps(); // Created_at and updated_at
    });
}

};
