<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EditHistory extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'form_id',
        'form_response_id',
        'user_id',
        'from_department_id'
    ];

    public function form(){

        return $this->belongsTo(Form::class);

    }
    public function user(){

        return $this->belongsTo(User::class);

    }
    public function from_department(){

        return $this->belongsTo(FormDepartment::class);

    }
    public function form_response(){

        return $this->belongsTo(FormResponse::class,'form_response_id');

    }
    public function get_response_by_name(){

        return $this->form_response()->with('response_by_name')->limit(1);

    }
}
