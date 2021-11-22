<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class FormDepartment extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'name', 'organization_id','created_by'
    ];

    public $table = 'form_departments';

    public function forms()
    {
        return $this->hasMany(Form::class);

    }
    public function organization(){

        return $this->belongsTo(Organization::class);

    }
}
