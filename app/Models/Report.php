<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Report extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'report_name',
        'organization_id',
        'form_id',
        'category_id',
        'description',
        'slug',
        'type',
        'created_by',
        'updated_by',
        'is_for_automation',
        'interval',
        'duration',
        'last_running_time',
    ];



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

    public function organization(){

        return $this->belongsTo(Organization::class);

    }

    public function created_by_user(){

        return $this->belongsTo(User::class,'created_by');

    }

}
