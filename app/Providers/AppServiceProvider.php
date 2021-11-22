<?php

namespace App\Providers;
use Illuminate\Database\Eloquent\Relations\Relation;

use Inertia\Inertia;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;
use Auth;

class AppServiceProvider extends ServiceProvider
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
        Relation::morphMap([
            'staff' => 'App\Models\Staff',
            'form' => 'App\Models\Form',
            'formAutomation' => 'App\Models\FormAutomation',
            'report' => 'App\Models\Report',
            'taskDetails' => 'App\Models\TaskDetails',
        ]);

        Inertia::share([
            'errors' => function () {
                return Session::get('errors')
                    ? Session::get('errors')->getBag('default')->getMessages()
                    : (object) [];
            },
        ]);

        Inertia::share('flash', function () {
            return [
                'message' => Session::get('message'),
                'error' => Session::get('error'),
            ];
        });

        Inertia::share([
          'auth' => function () {
          return [
          'user' => Auth::user() ? [
          'id' => Auth::user()->id,
          'name' => Auth::user()->name,
          'email' => Auth::user()->email,
          'user_type' => Auth::user()->user_type,
          'organization_id' => Auth::user()->organization_id,
          'organization' => Auth::user()->organization,
          'menu_access' => \config('settings.menu_access')[Auth::user()->user_type],
          ] : null,
          ];
          },
          ]);
          Schema::defaultStringLength(191);
    }
}
