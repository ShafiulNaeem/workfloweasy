<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class FormFieldOption extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'form__fields_id',
        'option_title',
        'option_value',
        'created_by',
        'updated_by',
        'field_option_type'
    ];

    public function field_option(){

           return $this->belongsTo(Form_Fields::class);

    }
}
