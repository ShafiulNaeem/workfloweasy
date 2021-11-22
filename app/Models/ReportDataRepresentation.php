<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ReportDataRepresentation extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'report_id',
        'form_id',
        'form_field_id',
        'total',
        'lowest',
        'highest',
        'average',
        'created_by',
        'updated_by',

    ];
}
