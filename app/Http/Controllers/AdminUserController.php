<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\User;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use App\DataTables\AdminsDataTable;
use App\Models\Role;
use Auth;

class AdminUserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, AdminsDataTable $dataTable)
    {
        $data = [];
        $results = [];
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $query);


        if (!empty($request->from_date) && !empty($request->to_date)){
            if (!empty($where)){
                $results = Admin::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->with('role')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }else{
                $results = Admin::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->with('role')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }
        }else{
            $results = Admin::where($where)->with('user')
                ->latest()
                ->paginate(10)
                ->appends($request->except('organization_id','access'));
        }

        $data['query'] = $query;
        $data['data'] = $results;
        return Inertia::render('users/admin/index', ['data' => $data, 'dataTable' => $dataTable]);
    }

    // search query builder
    public function getQuery($where, $query)
    {

        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['admins.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }

            if ($query['search_type'] == 'id') {
                $where = array_merge(array(['admins.user_code', $query['search_text']]), $where);
            }

            if ($query['search_type'] == 'email') {
                $where = array_merge(array(['admins.email', $query['search_text']]), $where);
            }

        }

        return $where;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
       // return mt_rand(100000, 999999);
//        $data['code'] = mt_rand(100000, 999999);
        $data['roles'] = Role::where('name','admin')->get();
        return Inertia::render('users/admin/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'role_id' => ['required'],
            'email' => 'required|email|unique:admins,email||unique:users,email',
            'phone' => 'required|unique:admins|min:11|max:11|regex:/[0-9]/',
            'password' => 'required|required_with:confirm_password|same:confirm_password|min:7|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',

            'confirm_password' => ['required'],
//           'role_id' => ['required'],

        ])->validate();

        $userStatus = '';
        $data = $request->all();
        $data['password'] = Hash::make($request->password);
        $data['created_by'] = Auth::user()->id;
        $data['is_active']= 1;
        $data['role_id']= $request->role_id;

        if ($request->status == 1){
            $userStatus = 'ACTIVE';
        }else{
            $userStatus = 'INACTIVE';
        }


      $us =  User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
            'role_id' => $data['role_id'],
            'created_by' => $data['created_by'],
            'user_type' => 'admin',
            'is_active' => $data['is_active'],
            'status' => $userStatus

        ]);

       $data['user_code'] = mt_rand(100000, 999999);
       $data['user_id'] = $us->id;
       Admin::create($data);

        if ($request->index == null){
            return redirect()->route('admins.create')->with('message', ' User Created Successfully');
        }else{
            return Redirect::route('admins.index')->with('message', ' User Created Successfully.');
        }


    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Admin::find($id);
        $user= User::where('id',$data->user_id)->first();
        $data['title'] = 'View User';
        $data['password'] = '';
        $data['role_id'] = $user->role_id;
        if ($user->status == 'ACTIVE'){
            $data['status'] =1;
        }else{
            $data['status'] =2;
        }
        $data['roles'] = Role::where('name','admin')->get();
        return Inertia::render('users/admin/view', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = Admin::find($id);
        $user= User::where('id',$data->user_id)->first();
        $data['role_id'] = $user->role_id;
        if ($user->status == 'ACTIVE'){
            $data['status'] =1;
        }else{
            $data['status'] =2;
        }
        $data['title'] = 'Update User';
        $data['password'] = '';
        $data['roles'] = Role::where('name','admin')->get();
        return Inertia::render('users/admin/edit', ['data' => $data]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request,$id)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'email' => "required|email|unique:users,email,$request->user_id,id|unique:admins,email,$request->id,id",
            'phone' => "required|min:11|max:11|regex:/[0-9]/|unique:admins,phone,$request->id,id|",

        ])->validate();

        $data = $request->all();

        $use = Admin::where('user_id', $request->input('user_id'))->first();
                $data['updated_by'] = Auth::user()->id;
                if ($request->has('id')) {
                   Admin::find($request->input('id'))->update([
                       'name' => $data['name'],
                       'email' => $data['email'],
                       'phone' => $data['phone'],
                       'updated_by' => $data['updated_by']
                   ]);

                   $user =  User::find($request->input('user_id'));

                   $user->name = $request->input('name');
                   $user->email = $request->input('email');
                   $user->status = $request->input('status');
                   $user->role_id = $request->input('role_id');
                   $user->save();

                    return redirect()->route('admins.show',$request['id'])
                        ->with('message', 'User Updated Successfully.');
                }

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        //return $request->all();
        if ($request->has('id')) {
            $admin = Admin::find($request->input('id'));
            $admin->delete();
            User::find($admin->user_id)->delete();
            return redirect()->back()
            ->with('message', 'User Deleted Success');
        }
    }
    /*============== Show the form for editing update user from Client Manager =============*/
    public function editPersonal($id){
        $data = Admin::find($id);
        $data['title'] = 'Update Personal';
        $data['password'] = '';
        return Inertia::render('users/admin/editPersonal', ['data' => $data]);
    }
    /*============== Show the form for editing update Password from Client Manager =============*/
    public function editPassword($id){
        $data = Admin::find($id);
        $data['title'] = 'Update Password';
        $data['password'] = '';
        return Inertia::render('users/admin/editpassword', ['data' => $data]);
    }
   /*============== Show the form for editing reset Password from Client Manager =============*/
    public function getResetPassword($id){
         $data = Admin::find($id);
        $data['title'] = 'Update Password';
        $data['password'] = '';
        return Inertia::render('users/admin/resetpass', ['data' => $data]);
    }
/*============== Reset  Password Client Manager =============*/
    public function resetPassword(Request $request){

           Validator::make($request->all(), [
            'new_password' => 'required|required_with:confirm_new_password|same:confirm_new_password|min:7|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
            'confirm_new_password' => ['required'],
        ])->validate();

        $data = $request->all();
        $use = User::where('id', $request->input('user_id'))->first();

        if ($use->id){
             $user =   User::find($request->input('user_id'));
             $user->password = Hash::make($data['new_password']);
             $user->save();
             return redirect()->route('admins.show',$request['id'])->with('message', 'User Password Reset Successfully.');
         }else {
            return redirect()->back()->with('message', 'Something Went to Wrong!');
        }

    }
/*============== Change  Password Client Manager =============*/
  public function changePassword(Request $request){
      $data = $request->all();
      $user = User::where('id', $request->input('user_id'))->first();
      Validator::make($data, [
          'old_password' => 'required',
          'new_password' => 'required|required_with:confirm_new_password|same:confirm_new_password|min:7|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
          'confirm_new_password' => ['required'],
      ])->after(function ($validator) use ($user, $data) {
          if (! Hash::check($data['old_password'], $user->password)) {
              $validator->errors()->add('old_password', __('The provided password does not match your old password.'));
          }
      })->validate();

      $user->password = Hash::make($data['new_password']);
      $user->save();
      return redirect()->route('admins.show',$request['id'])->with('message', 'Password Update Successfully.');

    }

}
