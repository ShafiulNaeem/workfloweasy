<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Department;
use App\Models\FormAutomation;
use App\Models\FormSetting;
use App\Models\Organization;
use App\Models\Task;
use App\Models\Type;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class FormAutomationController extends Controller
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

        $data = FormAutomation::where($where)->with('organization','users', 'departments', 'categories', 'types')->latest();
        $data = $this->search($data, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($request->except('organization_id','access'));
        $param['query'] = $query;
        $param['data'] = $data;

        return Inertia::render('form_automation/index', ['data' => $param]);
    }

    // filtering by department,category,type,user
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
        if($request->search_type == 'user'){
            $data = $data->whereHas('users', function($q) use($request){
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
                $where = array_merge(array(['form_automations.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
        }

        if (!empty($request->organization_id)){
            $where = array_merge(array(['form_automations.organization_id', $request->organization_id]), $where);
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
        $data['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $data['organizations'] = Organization::all();

        } else {
            $data['organization_id'] = Auth::user()->organization_id;
        }

        return Inertia::render('form_automation/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'due_date' => ['required'],
            'instruction' => ['required'],
            'organization_id' => ['required']
        ])->validate();

        $data = $request->all();
        $data['created_by'] = Auth::user()->id;
//        $data['organization_id'] = Auth::user()->organization_id;
        $formAutomation = FormAutomation::create($data);

        $formAutomation->departments()->sync($request->department_ids);
        $formAutomation->categories()->sync($request->category_ids);
        $formAutomation->types()->sync($request->type_ids);
        $formAutomation->users()->sync($request->user_ids);

        if ($request->index == null){
            return redirect()->back()->with('message', 'Automation Created Successfully');
        }else{
            return Redirect::route('formAutomation.index')->with('message', 'Automation Created Successfully.');
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

        $data = FormAutomation::where('id',$id)->with('users', 'departments', 'categories', 'types')->first();
        $data['organizations'] = Organization::all();
        $data['all_departments'] = Department::all();
        $data['all_categories'] = Category::all();
        $data['all_types'] = Type::all();
        $data['all_users'] = User::all();
        $data['all_task'] = Task::with('started_by','created_by_name','taskdetails')
            ->where('automation_id',$id)
            ->where('task_type', 'AUTOMATED')->latest()
            ->paginate(10);

        return Inertia::render('form_automation/view', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = FormAutomation::where('id',$id)->with('users', 'departments', 'categories', 'types')->first();
        $data['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $data['organizations'] = Organization::all();

        } else {
            $data['organization_id'] = $data->organization_id;

        }
        return Inertia::render('form_automation/edit', ['data' => $data]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        Validator::make($request->all(), [
            'name' => ['required'],
            'due_date' => ['required'],
            'instruction' => ['required'],
            'organization_id' => ['required']
        ])->validate();

        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;

        $formAutomation = FormAutomation::find($id);
        $formAutomation->update($data);

        $formAutomation->departments()->sync($request->department_ids);
        $formAutomation->categories()->sync($request->category_ids);
        $formAutomation->types()->sync($request->type_ids);
        $formAutomation->users()->sync($request->user_ids);

        return Redirect::route('formAutomation.show',$id)->with('message', 'Automation Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $formSetting = FormSetting::where('form_automation_id',$id)->count();
        $task = Task::where([
            'task_details_id' => $id,
            'task_type' => 'AUTOMATED',
        ])->count();
        if ($formSetting > 0 or $task > 0 ) {
            return redirect()->back()->with('message', 'You Can Not Delete This Automation');
        } else {
            FormAutomation::find($id)->delete();
            return redirect()->back()->with('message', 'Automation Deleted Successfully.');
        }
    }
}
