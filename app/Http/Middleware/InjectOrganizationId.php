<?php

namespace App\Http\Middleware;
use App\Models\Staff;
use Inertia\Inertia;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class InjectOrganizationId
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {

        $user = Auth::user();
        if ($user){
            if ($user->user_type != 'admin'){
                $params['organization_id'] = $user->organization_id;

                $staff = Staff::where('user_id', $user->id)->first();
                if($staff && $user->user_type == 'staff'){
                    $params['access']['user_type'] = $user->user_type;
                    $params['access']['department_ids'] = $staff->departments->pluck('id');
                    $params['access']['category_ids'] = $staff->categories->pluck('id');
                    $params['access']['type_ids'] = $staff->types->pluck('id');
                }

                $request->merge($params);
            }
        }

        return $next($request);
    }
}
