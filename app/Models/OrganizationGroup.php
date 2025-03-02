<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class OrganizationGroup extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'name','is_default'
    ];

    public $table = 'organization_groups';

    public function groups()
    {
        return $this->hasMany(Organization::class);

    }
}
