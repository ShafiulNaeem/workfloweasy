<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Routing\Route;

class Permission extends Model
{
    use HasFactory;
//    protected $fillable = [
//        'name',
//        'description',
//
//    ];

    public function test(){
        $permission_ids = array(); // an empty array of stored permission IDs
        // iterate though all routes
        foreach (\Illuminate\Support\Facades\Route::getRoutes()->getRoutes() as $key => $route)
        {
            // get route action
            $action = $route->getActionname();
            // separating controller and method
            $_action = explode('@',$action);

             $controller = $_action[0];
             $method = end($_action);

             $permission = new Permission;
             $permission->controller = $controller;
             $permission->method = $method;
             $permission->save();
             // add stored permission id in array
//             $permission_ids[] = $permission->id;

            array_push($permission_ids, $permission->id);

            }
    }

}
