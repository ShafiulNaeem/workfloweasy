<?php

namespace App\Http\Controllers;

use App\Models\Department;
use App\Models\Role;
use App\Models\User;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * User list
     *
     */
    public function index()
    {
        $data = User::with('department')->get();

        $param['data'] = $data;

        return Inertia::render('user/index', ['param' => $param]);
    }

    /**
     * Create User
     */
    public function create()
    {
        // $param['roles'] = Role::select('id', 'name', 'description')->get();
        // $param['hospitals'] = Hospital::select(['name', 'id'])->with('departments')->get();

        return Inertia::render('user/create', ['param' => $param]);
    }

    /**
     * Store User
     *
     * @param  $request
     */
    public function store(Request $request)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
        ])->validate();

        $data = $request->all();

        $data['password'] = Hash::make('12345678');

        User::create($data);

        return Redirect::route('users.index')->with('message', 'User Created Successfully.');
    }


    /**
     * Edit User
     *
     * @param $id
     */
    public function edit(User $user)
    {
        $data = User::find($user->id);

        $param['data'] =  $data;
        $param['roles'] = Role::select('id', 'name', 'description')->get();
        $param['hospitals'] = Hospital::select(['name', 'id'])->with('departments')->get();

        return Inertia::render('user/edit', ['param' => $param]);
    }

    /**
     * Update User
     *
     * @param $request
     * @param  $id
     */
    public function update(Request $request, User $user)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
        ])->validate();

        if ($request->has('id')) {
            User::find($request->input('id'))->update($request->all());
            return redirect()->back()
                ->with('message', 'User Updated Successfully.');
        }
    }

    /**
     * Destroy User
     *
     * @param  $id
     */
    public function destroy(Request $request)
    {
        if ($request->has('id')) {
            User::find($request->input('id'))->delete();
            return redirect()->back();
        }
    }
}
