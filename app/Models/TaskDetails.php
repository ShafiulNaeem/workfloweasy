<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TaskDetails extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'name',
        'instruction',
        'due_date',
        'organization_id',
        'created_by',
        'updated_by',
    ];

    public function organization()
    {
        return $this->belongsTo(Organization::class);
    }

    /**
     * Get all of the departments for the Form Automation.
     */
    public function departments()
    {
        return $this->morphToMany(Department::class, 'departmentable');
    }

    /**
     * Get all of the categories for the  Form Automation.
     */
    public function categories()
    {
        return $this->morphToMany(Category::class, 'categoryable');
    }

    /**
     * Get all of the types for the  Form Automation.
     */
    public function types()
    {
        return $this->morphToMany(Type::class, 'typeable');
    }

    /**
     * Get all of the users for the  Form Automation.
     */
    public function users()
    {
        return $this->morphToMany(User::class, 'userables');
    }
}
