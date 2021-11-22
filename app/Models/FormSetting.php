<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class FormSetting extends Model
{
    use HasFactory;
    protected $fillable = [
        'is_public', 'is_password_protected','password','form_id','form_automation_id'
    ];

    public $table = 'form_settings';

    public function formAutomation(){
        return $this->belongsTo(FormAutomation::class);
    }

}
