<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportDataRepresentationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_data_representations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('report_id');
            $table->foreignId('form_id')->nullable();
            $table->json('form_field_id')->nullable();
            $table->boolean('total')->default(0);
            $table->boolean('lowest')->default(0);
            $table->boolean('highest')->default(0);
            $table->boolean('average')->default(0);
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
        Schema::dropIfExists('report_data_representations');
    }
}
