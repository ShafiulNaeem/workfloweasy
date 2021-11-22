<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Organization extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'name',
        'email',
        'code',
        'phone',
        'website',
        'contact_person_name',
        'contact_person_email',
        'is_active',
        'organization_groups_id',
        'subscriptions_id',
        'status',
        'created_by',
        'updated_by',
    ];
    public function organizationGroup()
    {
        return $this->belongsTo(OrganizationGroup::class);
    }
    public function subscription()
    {
        return $this->belongsTo(Subscription::class,'subscriptions_id');
    }
}
