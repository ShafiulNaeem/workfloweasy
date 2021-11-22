<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Form extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'Form_title',
        'description',
        'organization_id',
        'slug',
        'created_by',
        'updated_by'
    ];

    public function organization(){
           return $this->belongsTo(Organization::class);
    }

    public function category(){
           return $this->belongsTo(Category::class);
    }

    public function type(){
        return $this->belongsTo(Type::class);
    }


     public function form_responses(){
         return $this->hasMany(FormResponse::class);
     }

    public function get_response_field(){

        return $this->form_responses()->with('response');
    }


    public function department(){
           return $this->belongsTo(Department::class, 'department_id', 'id');
    }

    public function get_department_names(){
        if ($this->department_id){
            return Department::whereIn('id', json_decode($this->department_id))->pluck('name');
        }
    }

    public function get_category_names(){
        if($this->category_id){
            return Category::whereIn('id', json_decode($this->category_id))->pluck('name');
        }
    }

    public function get_type_names(){
        if($this->type_id){
            return Type::whereIn('id', json_decode($this->type_id))->pluck('name');
        }
    }


    /**
     * Get all of the departments for the staff.
     */
    public function departments()
    {
        return $this->morphToMany(Department::class, 'departmentable');
    }

    /**
     * Get all of the categories for the staff.
     */
    public function categories()
    {
        return $this->morphToMany(Category::class, 'categoryable');
    }

    /**
     * Get all of the types for the staff.
     */
    public function types()
    {
        return $this->morphToMany(Type::class, 'typeable');
    }

    public function formSetting(){
        return $this->hasOne(FormSetting::class, 'form_id', 'id');
    }


}
