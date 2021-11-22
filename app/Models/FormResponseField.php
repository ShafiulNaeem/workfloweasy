<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FormResponseField extends Model
{
    use HasFactory;

    protected $fillable = [
        'form_id',
        'form_field_id',
        'form_response_id',
        'response_value'
    ];

    public function form(){

           return $this->belongsTo(Form::class);

    }

    public function fields(){

           return $this->belongsTo(Form_Fields::class, 'form_field_id', 'id');

    }

    public function response(){

           return $this->belongsTo(FormResponse::class);

    }
}
