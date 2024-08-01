<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('movimiento_carpetas', function (Blueprint $table) {
            $table->string('archivo_nombre')->nullable();
        });
    }

    public function down()
    {
        Schema::table('movimiento_carpetas', function (Blueprint $table) {
            $table->dropColumn('archivo_nombre');
        });
    }

};
