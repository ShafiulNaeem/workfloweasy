<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFormFieldsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('form__fields', function (Blueprint $table) {
            $table->id();
            $table->foreignId('form_id');
            $table->string('field_type');
            $table->string('field_label');
            $table->string('field_name')->nullable();
            $table->string('field_placeholder')->nullable();
            $table->string('field_default_value')->nullable();
            $table->boolean('field_is_required')->nullable();
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
        Schema::dropIfExists('form__fields');
    }
}
