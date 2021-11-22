<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportDateFiltersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_date_filters', function (Blueprint $table) {
            $table->id();
            $table->foreignId('report_id');
            $table->foreignId('form_id');
            $table->foreignId('form__fields_id');
            $table->string('start_date')->nullable(); 
            $table->string('end_date')->nullable(); 
            $table->enum('filter_type', [1, 2]);
            $table->softDeletes('deleted_at', 0);
            $table->integer('created_by')->nullable();
            $table->integer('updated_by')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('report_date_filters');
    }
}
