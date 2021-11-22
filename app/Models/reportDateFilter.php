<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class reportDateFilter extends Model
{
    use HasFactory;
    protected $fillable=['report_id', 'form_id', 'form__fields_id', 'start_date', 'end_date', 'filter_type'];

    
    public function formsFields(){
        return $this->belongsTo(Form_Fields::class, 'form__fields_id', 'id');
    }
}
