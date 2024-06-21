<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('citas', function (Blueprint $table) {
            $table->id();
            $table->timestamps();

            $table->dateTime('fecha');
            $table->integer('hora_cita');

            $table->bigInteger('id_servicios');
            $table->bigInteger('id_usuario');
            $table->bigInteger('id_auto');

            $table->foreign('id_servicios')->references('id')->on('servicios');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->foreign('id_auto')->references('id')->on('autos');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('citas');
    }
};
