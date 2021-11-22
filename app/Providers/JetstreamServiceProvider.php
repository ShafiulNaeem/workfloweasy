<?php

namespace App\Providers;

use App\Actions\Jetstream\DeleteUser;
use Illuminate\Support\ServiceProvider;
use Laravel\Jetstream\Jetstream;
use Laravel\Fortify\Fortify;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use PhpParser\Node\Stmt\If_;
use Session;

class JetstreamServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {

        $this->configurePermissions();

        Jetstream::deleteUsersUsing(DeleteUser::class);

        Fortify::authenticateUsing(function (Request $request) {
        $user = User::where('email', $request->email)->where('is_active', '1')->with('organization')->first();

        if (!empty($user)){
            if ($user->status == 'ACTIVE'){
                if ($user->user_type == 'admin'){
                    if ($user &&
                        Hash::check($request->password, $user->password)) {
                        return $user;
                    }
                }else{
                    if ($user->organization->status == 1){
                        if ($user &&
                            Hash::check($request->password, $user->password)) {
                            return $user;
                        }
                    }else{
                        Session::flash('status', 'Your account access is restricted, please contact with administrator!');
                        return false;
                    }

                }

            }else{
                Session::flash('status', 'Your account access is restricted, please contact with administrator!');
                return false;
            }

        }else{
            Session::flash('status', 'Your Account Could Not Found!');
            return false;
        }

//        if ($user &&
//            Hash::check($request->password, $user->password)) {
//            return $user;
//        }

    });
    }

    /**
     * Configure the permissions that are available within the application.
     *
     * @return void
     */
    protected function configurePermissions()
    {
        Jetstream::defaultApiTokenPermissions(['read']);

        Jetstream::permissions([
            'create',
            'read',
            'update',
            'delete',
        ]);
    }
}
