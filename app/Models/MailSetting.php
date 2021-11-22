<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MailSetting extends Model
{
    use HasFactory;
    protected $fillable =[
        'protocol',
        'type',
        'host',
        'port',
        'email',
        'password',
        'organization_id',
        'created_by',
        'updated_by'
    ];
    public function organization(){

        return $this->belongsTo(Organization::class);

    }
}
