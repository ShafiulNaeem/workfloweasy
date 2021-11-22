<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReportAutomationHistory extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'report_id',
        'report_automation_id',
        'previous_running_time',
        'last_running_time',
        'created_by',
        'updated_by'
    ];

    public function report(){
        return $this->belongsTo(Report::class, 'report_id');
    }

    public function reportAutomation(){
        return $this->belongsTo(Report::class, 'report_automation_id','id');
    }
}
