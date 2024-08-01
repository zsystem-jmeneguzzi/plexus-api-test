<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCarpetaTagTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('carpeta_tag', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('carpeta_id');
            $table->unsignedBigInteger('tag_id');
            $table->timestamps();

            $table->foreign('carpeta_id')->references('id')->on('carpetas')->onDelete('cascade');
            $table->foreign('tag_id')->references('id')->on('tags')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('carpeta_tag');
    }
}
