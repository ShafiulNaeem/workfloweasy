<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Admin extends Model
{
  use HasFactory;
  use SoftDeletes;
  protected $fillable = [
      'name',
      'email',
      'phone',
      'user_id',
      'user_code',
      'updated_by',
      'created_by'

  ];
  public function user(){

         return $this->belongsTo(User::class);

  }
  public function role(){

         return $this->belongsTo(Role::class);

  }
}
