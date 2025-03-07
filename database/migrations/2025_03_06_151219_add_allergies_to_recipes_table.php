<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up()
    {
        Schema::table('recipes', function (Blueprint $table) {
            if (!Schema::hasColumn('recipes', 'dietary_preferences')) {
                $table->string('dietary_preferences')->nullable();
            }

            if (!Schema::hasColumn('recipes', 'allergies')) {
                $table->string('allergies')->nullable()->after('dietary_preferences');
            }
        });
    }

    
    public function down()
    {
        Schema::table('recipes', function (Blueprint $table) {
            $table->dropColumn(['dietary_preferences', 'allergies']);
        });
    }
};
