<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Type extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'name',
        'organization_id',
        'created_by',
        'updated_by'
    ];

    public function organization(){

        return $this->belongsTo(Organization::class);

    }
}
