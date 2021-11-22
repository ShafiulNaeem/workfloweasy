<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Task extends Model
{
    use HasFactory;
    protected $fillable = [
        'due_date',
        'started_by_id',
        'start_time',
        'end_time',
        'status',
        'task_status',
        'task_reference_type',
        'task_reference_id',
        'created_by',
        'status',
        'task_details_id',
        'task_type',
        'automation_id',
        'task_code'
    ];


    public function taskdetails(){
        return $this->belongsTo(TaskDetails::class, 'task_details_id', 'id');
    }

    public function created_by_user(){
        return $this->belongsTo(User::class, 'created_by', 'id');
    }

    public function started_by(){
        return $this->belongsTo(User::class, 'started_by_id', 'id');
    }

    public function created_by_name(){
        return $this->belongsTo(User::class, 'created_by', 'id');
    }

    public function get_taskdetails(){
        return $this->taskdetails()->with('organization','users', 'departments', 'categories', 'types')->limit(100);
    }

}
