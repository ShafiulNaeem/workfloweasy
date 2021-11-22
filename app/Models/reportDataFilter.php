<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class reportDataFilter extends Model
{
    use HasFactory;
    protected $fillable = ['report_id', 'form_id', 'form__fields_id','filter_type', 'compare_operator', 'compare_value'];
}
