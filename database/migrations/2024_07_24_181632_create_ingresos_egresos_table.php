<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateIngresosEgresosTable extends Migration
{
    public function up()
    {
        Schema::create('ingresos_egresos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('carpeta_id');
            $table->unsignedBigInteger('user_id');
            $table->string('concepto');
            $table->decimal('monto', 8, 2);
            $table->enum('tipo', ['ingreso', 'egreso']);
            $table->date('fecha');
            $table->timestamps();

            $table->foreign('carpeta_id')->references('id')->on('carpetas')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('ingresos_egresos');
    }
}
