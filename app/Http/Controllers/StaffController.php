<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Task;
use App\Models\Type;
use Illuminate\Http\Request;
use App\Models\Staff;
use App\Models\Organization;
use App\Models\Department;
use App\Models\Role;
use App\Models\User;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Response;
use Auth;

class StaffController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $request);

        $data = Staff::where($where)->with('organization', 'role', 'departments', 'categories', 'types')->latest();
        $data = $this->search($data, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
                $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($request->except('organization_id','access'));

        $param['query'] = $query;
        $param['data'] = $data;

        return Inertia::render('Staff/index', ['data' => $param]);
    }

    // search by department,category,type
    public function search($data, $request){

        if($request->search_type == 'category'){
            $data = $data->whereHas('categories', function($q) use($request){
                $q->where('name', $request->search_text);
            });
        }
        if($request->search_type == 'department'){
            $data = $data->whereHas('departments', function($q) use($request){
                $q->where('name', $request->search_text);
            });
        }
        if($request->search_type == 'type'){
            $data = $data->whereHas('types', function($q) use($request){
                $q->where('name', $request->search_text);
            });
        }

        return $data;

    }

    // search query builder
    public function getQuery($where, $request)
    {
        $query = $request->query();
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['staff.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
//            if ($query['search_type'] == 'id') {
//                $where = array_merge(array(['staff.id', $query['search_text']]), $where);
//            }
            if ($query['search_type'] == 'email') {
                $where = array_merge(array(['staff.email', $query['search_text']]), $where);
            }
            if ($query['search_type'] == 'phone') {
                $where = array_merge(array(['staff.phone', $query['search_text']]), $where);
            }

        }

        if (!empty($request->organization_id)){
            $where = array_merge(array(['staff.organization_id', $request->organization_id]), $where);
        }

        return $where;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {

        Auth::user()->organization_id;

        $data['code'] = mt_rand(10000000, 99999999);
        $data['organizations'] = Organization::all();
        $data['roles'] = Role::where('name',  'staff')->get();

        $data['departments'] = Department::where('organization_id', $request->organization_id)->get();
        $data['categories'] = Category::where('organization_id', $request->organization_id)->get();
        $data['types'] = Type::where('organization_id', $request->organization_id)->get();
        if(Auth::user()->user_type == 'owner' || Auth::user()->user_type == 'staff'){
            $data['user_type'] = 'owner';
        }


        return Inertia::render('Staff/create', ['data' => $data]);
    }

    public function departments($id)
    {
        $data = Department::where('organization_id', $id)->get();

        return response()->json($data, Response::HTTP_OK);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       // dd('1');
      // dd($request->all());
        Validator::make($request->all(), [
            'name' => ['required'],
            'email' => 'required|email|unique:staff,email|unique:users,email',
            'password' => 'required|required_with:confirm_password|same:confirm_password|min:7|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
            'confirm_password' => ['required'],
            'phone' => 'required|unique:staff|min:11|max:11|regex:/[0-9]/',
            'role_id' => ['required'],
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['organization_id'] = $request->organization_id;
        $data['password'] = Hash::make($request->password);
        $data['created_by'] = Auth::user()->id;
        $us = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
            'role_id' => $data['role_id'],
            'created_by' => $data['created_by'],
            'user_type' => 'staff',
            'organization_id' => $data['organization_id']
        ]);
        $data['user_id'] = $us->id;

        $staff = Staff::create($data);
        // create many to many table data
        $staff->departments()->sync($request->department_ids);
        $staff->categories()->sync($request->category_ids);
        $staff->types()->sync($request->type_ids);

        if($request->saveAndAnother == 1){
           return redirect()->back()->with('message', 'Staff Created Successfully.');
        //  return Redirect::route('staffs.create')->with('message', 'Staff Created Successfully.');
        }else{
            return Redirect::route('staffs.index')->with('message', 'Staff Created Successfully.');
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
        $data = Staff::where('id', $id)->with('departments', 'categories', 'types')->first();

        $data['organizations'] = Organization::all();
        $data['all_departments'] = Department::where('organization_id', $data->organization_id)->get();
        $data['all_categories'] = Category::where('organization_id', $data->organization_id)->get();
        $data['all_types'] = Type::where('organization_id', $data->organization_id)->get();

        $data['roles'] = Role::all();
        $data['title'] = 'View Staff';

        return Inertia::render('Staff/view', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request, $id)
    {

        $data = Staff::find($id);
        if (Auth::user()->user_type == 'admin') {
            $data['organizations'] = Organization::all();
            $data['departments'] = Department::all();
        } else {
             $data['organization_id'] = $request->organization_id;
            $data['departments'] = Department::where('organization_id', $data['organization_id'])->get();
        }
        $data['roles'] = Role::where('name', 'staff')->get();
        $data['title'] = 'Update Staff';

        return Inertia::render('Staff/edit', ['data' => $data]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'role_id' => ['required'],
            'email' => 'required|email',
            'phone' => 'required',
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();

        $data = $request->all();
        $user = User::where('id', $request->input('user_id'))->first();
        $data['updated_by'] = Auth::user()->id;

        if ($user->role->name == 'admin' || $user->user_type =='admin'){
            $organization_id = null;
        }else{
            $organization_id = $request->organization_id;
        }

        //when staff status change
        $status_id = ((int) $request->status);
        if ($status_id  === 1) {
            $data['sts'] = 'ACTIVE';
        }else{
            $data['sts'] = 'INACTIVE';
        }
        $userData = [
            'name' => $data['name'],
            'email' => $data['email'],
            'updated_by' => $data['updated_by'],
            'is_active' => $data['status'],
            'status' => $data['sts'],
            'organization_id' =>$organization_id,
        ];

        $checkData =  Staff::where('id', $request->id)->where('email', $request->email)->where('phone', $request->phone)->first();
        if(empty($checkData)){
            $checkEmail =  Staff::where('id','!=', $request->id)->where('email', $request->email)->get();
            $checkPhone =  Staff::where('id' ,'!=', $request->id)->where('phone', $request->phone)->get();
          if($checkEmail->isNotEmpty()){
              Validator::make($request->all(), [
                  'email' => 'required|email|unique:staff,email|unique:users,email',
              ])->validate();

          }elseif( $checkPhone->isNotEmpty()){
              Validator::make($request->all(), [
                  'phone' => 'required|unique:staff|min:11|max:11|regex:/[0-9]/',
              ])->validate();
          }else{
            User::find($request->input('user_id'))->update($userData);

            $staff = Staff::find($id);
            $staff->update($data);
            $staff->departments()->sync($request->department_ids);
            $staff->categories()->sync($request->category_ids);
            $staff->types()->sync($request->type_ids);
          }

       }else{
        User::find($request->input('user_id'))->update($userData);

        $staff = Staff::find($id);
        $staff->update($data);
        $staff->departments()->sync($request->department_ids);
        $staff->categories()->sync($request->category_ids);
        $staff->types()->sync($request->type_ids);
       }

//       Auth::loginUsingId($request->input('user_id'), TRUE);
     return redirect()->route('staffs.show',$id)->with('message', 'Staff Updated Successfully.');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
            $staff = Staff::find($id);
            $staff->delete();
            User::find($staff->user_id)->delete();
            return redirect()->back()->with('message', 'Staff Deleted Successfully.');
//        }

    }

    public function staffView(Request $request, $id){
        $data = Staff::where('id', $id)->with('departments', 'categories', 'types')->first();

        $data['organizations'] = Organization::all();
        $data['all_departments'] = Department::where('organization_id', $data['organization_id'])->get();
        $data['all_categories'] = Category::where('organization_id', $data['organization_id'])->get();
        $data['all_types'] = Type::where('organization_id', $data['organization_id'])->get();

        $data['roles'] = Role::all();
        $data['title'] = 'View Staff';

        return Inertia::render('Staff/view', ['data' => $data]);
    }
    public function staffEdit(Request $request, $id){
         $data = Staff::where('id', $id)->with('departments', 'categories', 'types')->first();
         $data['organizations'] = Organization::all();
         $data['all_departments'] = Department::where('organization_id', $data->organization_id)->get();
         $data['all_categories'] = Category::where('organization_id', $data->organization_id)->get();
         $data['all_types'] = Type::where('organization_id', $data->organization_id)->get();

        $data['roles'] = Role::where('name', 'staff')->get();
        $data['title'] = 'Update Staff';
        $getUser =  User::find($data['user_id']);
        $data['status'] = $getUser->is_active;


        return Inertia::render('Staff/edit', ['data' => $data]);
    }

    public function passwordEdit(Request $request, $id){
        $data = Staff::find($id);

        $data['title'] = 'Update Password';
        $data['password'] = '';

        return Inertia::render('Staff/change', ['data' => $data]);
    }
    public function passwordUpdate(Request $request){

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

        return Redirect::route('staffs', $request->id)->with('message', 'Password Updated Successfully.');

    }
    
     public function ResetPassEdit(Request $request, $id){
        $data = Staff::find($id);
        $data['title'] = 'Reset Password';
        $data['password'] = '';

        return Inertia::render('Staff/reset', ['data' => $data]);
    }


    public function resetPassword(Request $request){
        Validator::make($request->all(), [
            'new_password' => 'required|required_with:confirm_new_password|same:confirm_new_password|min:7|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
            'confirm_new_password' => ['required'],
        ])->validate();
        $data = $request->all();
        $use = User::where('id', $request->input('user_id'))->first();

        if ($use == true){
             $user =   User::find($request->input('user_id'));
            $user->password = Hash::make($data['new_password']);
            $user->save();
            return Redirect::route('staffs', $request->id)->with('message', 'Password Reset Successfully.');
         }else {
            return redirect()->back()
                ->with('error', 'Member password not reset, please try again.');
        }
    }
}
