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
            $table->unsignedBigInteger('carpeta_id')->nullable();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('patient_id')->nullable();  // Cambiado de cliente_id a patient_id
            $table->string('concepto');
            $table->decimal('monto', 10, 2);
            $table->enum('tipo', ['ingreso', 'egreso', 'deuda']);
            $table->date('fecha');
            $table->timestamps();

            $table->foreign('carpeta_id')->references('id')->on('carpetas')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('patient_id')->references('id')->on('patients')->onDelete('cascade');  // Cambiado de cliente_id a patient_id
        });
    }

    public function down()
    {
        Schema::dropIfExists('ingresos_egresos');
    }
}

