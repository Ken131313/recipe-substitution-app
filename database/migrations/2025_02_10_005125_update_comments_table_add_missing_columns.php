<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateCommentsTableAddMissingColumns extends Migration
{
    public function up(): void
    {
        Schema::table('comments', function (Blueprint $table) {
            if (!Schema::hasColumn('comments', 'recipe_id')) {
                $table->foreignId('recipe_id')->after('id')->constrained()->onDelete('cascade');
            }
            if (!Schema::hasColumn('comments', 'user_id')) {
                $table->foreignId('user_id')->after('recipe_id')->constrained()->onDelete('cascade');
            }
            if (!Schema::hasColumn('comments', 'body')) {
                $table->text('body')->after('user_id');
            }
        });
    }

    public function down(): void
    {
        Schema::table('comments', function (Blueprint $table) {
            // Drop the columns (or drop the foreign key constraints first if necessary)
            $table->dropConstrainedForeignId('recipe_id');
            $table->dropConstrainedForeignId('user_id');
            $table->dropColumn('body');
        });
    }
}
