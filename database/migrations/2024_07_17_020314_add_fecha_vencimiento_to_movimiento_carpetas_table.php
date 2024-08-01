<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('movimiento_carpetas', function (Blueprint $table) {
            $table->date('fecha_vencimiento')->nullable();
        });
    }

    public function down()
    {
        Schema::table('movimiento_carpetas', function (Blueprint $table) {
            $table->dropColumn('fecha_vencimiento');
        });
    }
};
