<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Form;
use App\Models\FormDepartment;
use App\Models\OrganizationGroup;
use App\Models\Subscription;
use App\Models\Type;
use Illuminate\Http\Request;
use App\Models\Organization;
use App\Models\Department;
use App\Models\Staff;
use Illuminate\Http\Response;
use Inertia\Inertia;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class OrganizationUserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $data=[];
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $query);

        if (!empty($request->from_date) && !empty($request->to_date)){
            if (!empty($where)){
                $data = Organization::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->with('subscription')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }else{
                $data = Organization::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->with('subscription')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }

        }else{
            $data = Organization::where($where)
                ->with('subscription')
                ->latest()
                ->paginate(10)
                ->appends($request->except('organization_id','access'));
        }

        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('organization/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $query)
    {
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['organizations.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }

            if ($query['search_type'] == 'code') {
                $where = array_merge(array(['organizations.code', $query['search_text']]), $where);
            }

            if ($query['search_type'] == 'mobile') {
                $where = array_merge(array(['organizations.phone', $query['search_text']]), $where);
            }

            if ($query['search_type'] == 'email') {
                $where = array_merge(array(['organizations.email', $query['search_text']]), $where);
            }
            if ($query['search_type'] == 'website') {
                $where = array_merge(array(['organizations.website', $query['search_text']]), $where);
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
//        $data['code'] = mt_rand(1000000, 9999999);
        $data['organization_group'] = OrganizationGroup::all();
        $data['subscriptions'] = Subscription::where('name','Enterprise')->get();
        return Inertia::render('organization/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request) {
        Validator::make($request->all(), [
            'name' => ['required'],
            'email' => 'required|email|unique:users,email|unique:organizations,email|unique:staff,email',
            'phone' => 'required|unique:organizations,phone|min:8|regex:/^([0-9\s\-\+\(\)]*)$/',
           // 'password' => 'required_with:confirm_password|min:6|max:6|same:confirm_password',
            'password' => 'required|required_with:confirm_password|same:confirm_password|min:6|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
            'contact_person_email' => 'required|email|unique:organizations,contact_person_email|unique:users,email|unique:staff,email',
            'contact_person_name' => ['required'],
            'confirm_password' => ['required'],
            'subscriptions_id' => ['required'],
            'organization_groups_id' => ['required'],
            'website' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['password'] = Hash::make($request->password);
        $data['created_by'] = Auth::user()->id;
        $data['is_active'] = 1;
        $data['code'] = mt_rand(1000000, 9999999);

//        $data['organization_groups_id'] = 1;

        $org = Organization::create($data);

        if ($request->status == 1){
            $userStatus = 'ACTIVE';
        }else{
            $userStatus = 'INACTIVE';
        }

        $us = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
            'role_id' => '7',
            'created_by' => $data['created_by'],
            'user_type' => 'owner',
            'organization_id' => $org->id,
            'status' => $userStatus,

        ]);
        $data['user_id'] = $us->id;

        $formDepartment = FormDepartment::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $us->id
        ]);

        $category = Category::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $us->id
        ]);
        $type = Type::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $us->id
        ]);

        $department = Department::create([
            'name' => 'management',
            'organization_id' => $org->id,
            'created_by' => $us->id
        ]);

        $staff = Staff::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'role_id' => '7',
            'organization_id' => $org->id,
            'user_id' => $us->id,
            'created_by' => $us->id
        ]);

        // create many to many table data
        $staff->departments()->sync($department->id);
        $staff->categories()->sync($category->id);
        $staff->types()->sync($type->id);


        if ($request->index == null){
            return redirect()->back()->with('message', 'Organization User Created Successfully');
        }else{
            return Redirect::route('organization-users.index')->with('message', 'Organization User Created Successfully.');
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
        $data = Organization::find($id);
        $data['title'] = 'Update Organization';
        $data['password'] = null;
        $data['organization_group'] = OrganizationGroup::all();
        $data['subscriptions'] = Subscription::where('name','Enterprise')->get();

        return Inertia::render('organization/view', ['data' => $data]);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = Organization::find($id);
        $data['title'] = 'Update Organization';
        $data['password'] = null;
        $data['organization_group'] = OrganizationGroup::all();
        $data['subscriptions'] = Subscription::where('name','Enterprise')->get();

        return Inertia::render('organization/edit', ['data' => $data]);
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
//        dd($request->all());
        Validator::make($request->all(), [
            'name' => ['required'],
            'email' => "required|email|unique:organizations,email,$id,id",
            'phone' => "required|min:8|regex:/^([0-9\s\-\+\(\)]*)$/|unique:organizations,phone,$id,id",
            'contact_person_name' => ['required'],
            'contact_person_email' => "required|email|unique:organizations,contact_person_email,$id,id",
            'subscriptions_id' => ['required'],
            'organization_groups_id' => ['required'],
            'website' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;
        $org = Organization::find($id);

        if ($request->status == 1){
            $userStatus = 'ACTIVE';
        }else{
            $userStatus = 'INACTIVE';
        }

        $user = User::where([
            'email' => $org->email,
            'organization_id' => $org->id,
        ])->update([
            'name' => $request->name,
            'email' => $request->email,
            'status' => $userStatus,
            'updated_by' => $data['updated_by'],
        ]);

        $staff = Staff::where([
            'email' => $org->email,
            'organization_id' => $org->id,
        ])->update([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'updated_by' => $data['updated_by'],
        ]);
        $org->update($data);

        return redirect()->route('organization-users.show', $id)->with('message', 'Organization Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $organisation = Organization::find($id);

        $staff = Staff::where('organization_id', $organisation->id)->count();
        $form = Form::where('organization_id', $organisation->id)->count();
        $department = Department::where('organization_id', $organisation->id)->count();
        $category = Category::where('organization_id', $organisation->id)->count();
        if ($staff > 0 or $form > 0 or $department > 0 or $category) {
            return redirect()->back()->with('message', "Can't delete content!");
        }
        $organisation->delete();
        return redirect()->back()->with('message', "Deleted Successfully");
    }
    public function changePassword($id){
        $data = Organization::find($id);
        $data['title'] = 'Update Organization';
        $data['password'] = null;
        return Inertia::render('organization/changePass', ['data' => $data]);
    }

    public function changePasUpdate(Request $request)
    {
        Validator::make($request->all(), [
//            'password' => 'required_with:confirm_password|min:6|max:6|same:confirm_password',
            'password' => 'required|required_with:confirm_password|same:confirm_password|min:6|regex:/[a-z]/|regex:/[A-Z]/|regex:/[0-9]/',
//            'old_password' => ['required'],
            'confirm_password' => ['required']

        ])->validate();

        $data = $request->all();
        $id = $request->id;
        $password = Hash::make($request->password);
        User::where([
            'email' => $request->email,
            'organization_id' => $request->id,
        ])->update([
            'password' => $password
        ]);
        return redirect()->route('organization-users.show', $id)->with('message', "Password Updated Successfully!");
    }


    public function getData($id)
    {
        $departments = Department::where('organization_id', $id)->get();
        $form_departments = FormDepartment::where('organization_id', $id)->get();
        $categories = Category::where('organization_id', $id)->get();
        $types = Type::where('organization_id', $id)->get();
        $users = User::where('organization_id', $id)->get();
        $data['departments'] = $departments;
        $data['form_departments'] = $form_departments;
        $data['categories'] = $categories;
        $data['types'] = $types;
        $data['users'] = $users;
        return response()->json($data, Response::HTTP_OK);
    }

    //organization details
    public function organization_details(){

        $data = Organization::where('id', Auth::user()->organization_id)->first();
        $data['organization_group'] = OrganizationGroup::all();
        $data['subscriptions'] = Subscription::where('name','Enterprise')->get();

        return Inertia::render('organization/show', ['data' => $data]);
    }


}
