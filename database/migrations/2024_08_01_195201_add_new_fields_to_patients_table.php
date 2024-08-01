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
        Schema::table('patients', function (Blueprint $table) {
            $table->string('cuil')->nullable();
            $table->string('clave_seguridad_social')->nullable();
            $table->string('clave_fiscal')->nullable();
        });
    }

    public function down()
    {
        Schema::table('patients', function (Blueprint $table) {
            $table->dropColumn('cuil');
            $table->dropColumn('clave_seguridad_social');
            $table->dropColumn('clave_fiscal');
        });
    }

};
