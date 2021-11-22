<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportAutomationHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_automation_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('report_id')->nullable();
            $table->integer('report_automation_id')->nullable();
            $table->dateTime('previous_running_time')->nullable();
            $table->dateTime('last_running_time')->nullable();
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
        Schema::dropIfExists('report_automation_histories');
    }
}
