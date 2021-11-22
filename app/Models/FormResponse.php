<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FormResponse extends Model
{
    use HasFactory;

    protected $fillable = [
        'form_id',
        'response_by',
        'response_date',
        'status'
    ];

    public function form(){
           return $this->belongsTo(Form::class);
    }
    public function response_by_name(){

        return $this->belongsTo(User::class,'response_by','id');

    }
    public function response(){

           return $this->hasMany(FormResponseField::class);

    }

//    public function get_response_form_field(){
//
//        return $this->response()->with('form_responses');
//    }
}
