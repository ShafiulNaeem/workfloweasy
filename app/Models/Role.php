<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Role extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'name', 'status', 'permissions', 'created_by', 'updated_by'
    ];
    protected $casts = [
        'permissions' => 'array'
    ];

    public function permissions(){

           return $this->belongsTo(Permission::class);

    }
}
