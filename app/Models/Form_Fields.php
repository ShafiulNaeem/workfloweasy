<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Form_Fields extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'form_id',
        'field_type',
        'field_label',
        'field_instruction',
        'field_name',
        'field_placeholder',
        'field_default_value',
        'field_is_required',
        'field_order',
        'created_by',
        'updated_by'
    ];

    public function field(){

           return $this->belongsTo(Form::class);

    }
    public function form(){

        return $this->belongsTo(Form::class);
    }

    public function get_responses(){

        return $this->form()->with('form_responses');
    }

    public function get_responses_form_field(){

        return $this->form()->with('get_response_field');
    }



    public function options(){

           return $this->hasMany(FormFieldOption::class);

    }
}
