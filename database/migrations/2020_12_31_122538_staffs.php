<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Staffs extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      Schema::create('staff', function (Blueprint $table) {
          $table->id();
          $table->string('name');
          $table->string('email');
          $table->string('phone');
          $table->foreignId('organization_id');
          $table->foreignId('role_id');
          $table->foreignId('user_id');
          $table->timestamps();
          $table->softDeletes('deleted_at', 0);
          $table->integer('created_by')->nullable();
          $table->integer('updated_by')->nullable();
      });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
