<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Staff extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'name',
        'email',
        'phone',
        'organization_id',
        'role_id',
        'user_id',
        'created_by',
        'updated_by'

    ];


    public function organization()
    {

        return $this->belongsTo(Organization::class);

    }

    public function department()
    {

        return $this->belongsTo(Department::class);

    }

    public function user()
    {

        return $this->belongsTo(User::class);

    }

    public function role()
    {

        return $this->belongsTo(Role::class);

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

    public function get_department_names(){
        if ($this->department_ids){
            return Department::whereIn('id', json_decode($this->department_ids))->pluck('name');
        }
    }

    public function get_category_names(){
        if($this->category_ids){
            return Category::whereIn('id', json_decode($this->category_ids))->pluck('name');
        }
    }

    public function get_type_names(){
        if($this->type_ids){
            return Type::whereIn('id', json_decode($this->type_ids))->pluck('name');
        }
    }

}
