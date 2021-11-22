<?php

namespace App\Http\Controllers;

use App\Mail\TaskNotification;
use App\Mail\VerificationMail;
use App\Models\Category;
use App\Models\Department;
use App\Models\FormAutomation;
use App\Models\Report;
use App\Models\Staff;
use App\Models\TaskDetails;
use App\Models\Type;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Organization;
use App\Models\Task;
use App\Models\Form;
use App\Models\FormResponse;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class TaskController extends Controller
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

        $data = Task::with('get_taskdetails','taskdetails','started_by','created_by_name')->latest();
        $data = $this->filter($data);
        $data =  $data->where($where);
        $data = $this->search($data,$request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($request->except('organization_id','access'));
        $param['query'] = $request->except('organization_id','access');
        $param['data'] = $data;

        return Inertia::render('task/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $request)
    {
        $query = $request->query();
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'due_date') {
                $where = array_merge(array(['tasks.due_date','LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            if ($query['search_type'] == 'status') {
                $where = array_merge(array(['tasks.status', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            if ($query['search_type'] == 'task_status') {
                $where = array_merge(array(['tasks.task_status', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            if ($query['search_type'] == 'group') {
                $where = array_merge(array(['tasks.task_reference_type', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            if ($query['search_type'] == 'created_by') {
                $user = User::where('name','LIKE', '%' . $query['search_text'] . '%')->pluck('id');
                $created_by = Task::whereIn('created_by',$user)->pluck('created_by');

                $where = array_merge(array(['tasks.created_by',$created_by]), $where);
            }
            if ($query['search_type'] == 'started_by') {
                $user = User::where('name','LIKE', '%' . $query['search_text'] . '%')->pluck('id');
                $started_by = Task::whereIn('started_by_id',$user)->pluck('started_by_id');
                $where = array_merge(array(['tasks.started_by_id',$started_by]), $where);
            }

        }


        return $where;
    }

    public function filter($data){
        if (Auth::user()->user_type != 'admin'){
            $staff = Staff::where('user_id',Auth::user()->id)->with( 'departments', 'categories', 'types')->first();
            $departments_ids = $staff->departments->pluck('id');
            $category_ids = $staff->categories->pluck('id');
            $type_ids = $staff->types->pluck('id');

            $taskDetails = TaskDetails::whereHas('departments', function (Builder $query) use ($departments_ids) {
                $query->whereIn('department_id',$departments_ids);
            })->orWhereHas('categories', function (Builder $query) use ($category_ids) {
                $query->whereIn('category_id',$category_ids);
            })->orWhereHas('types', function (Builder $query) use ($type_ids) {
                $query->whereIn('type_id',$type_ids);
            })->orWhereHas('users', function (Builder $query) {
                $query->where('user_id',Auth::user()->id);
            })->pluck('id');

            $data = $data->whereIn('task_details_id',$taskDetails);
        }
        return $data;
    }

    //    for name and Departments
    public function search($data,$request){
        $query = $request->query();
        if (!empty($query['search_type']) && !empty($query['search_text'])) {
            if ($query['search_type'] == 'name') {
                $taskDetails = TaskDetails::where('name','LIKE', '%' . $query['search_text'] . '%')->pluck('id');
                $data = $data->whereIn('task_details_id',$taskDetails);
            }

            if ($query['search_type'] == 'department') {
                $departments_ids = Department::where('name','LIKE', '%' . $query['search_text'] . '%')->pluck('id');
                $taskDetails = TaskDetails::whereHas('departments', function (Builder $query) use ($departments_ids) {
                    $query->whereIn('department_id',$departments_ids);
                })->pluck('id');

                $data = $data->whereIn('task_details_id',$taskDetails);
            }
        }
        return $data;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function pending_task(Request $request)
    {
        $data = [];
        $query = $request->query();
        $task_ids = Task::where('user_id', Auth::user()->id)->pluck('form_id');

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = FormResponse::whereBetween('created_at', [$request->from_date, $request->to_date])
                ->whereIn('form_id', $task_ids)
                ->with('form.category')
                ->latest()
                ->paginate(10)
                ->appends($query);
            //dd($data);
        }else{
            $data = FormResponse::whereIn('form_id', $task_ids)
//            ->where('is_approved', 0)
                ->with('form.category')
                ->latest()
                ->paginate(10)
                ->appends($query);
            //dd($data);
        }


        $param['query'] = $query;
        $param['data'] = $data;

        return Inertia::render('task/pending_task', ['data' => $param]);
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

        return Inertia::render('task/create', ['data' => $data]);
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

        $data['task_code'] = mt_rand(100, 999);
        $name = $request->name;
        $data['name'] = $name .' '.'#'.$data['task_code'];

        $taskDetails = TaskDetails::create($data);
        $taskDetails->departments()->sync($request->department_ids);
        $taskDetails->categories()->sync($request->category_ids);
        $taskDetails->types()->sync($request->type_ids);
        $taskDetails->users()->sync($request->user_ids);

        $data['task_reference_type'] = $request->task_reference_type;
        if ($data['task_reference_type'] == 'General'){
            $data['task_reference_id'] = $taskDetails->id;
        }else{
            $data['task_reference_id'] = $request->task_reference_id;
        }

        $code = $data['task_code'];
        $task_params = [
            'task_details_id' => $taskDetails->id,
            'task_type' => $data['task_type'],
            'due_date' => $data['due_date'],
            'task_reference_type' => $data['task_reference_type'],
            'task_reference_id' => $data['task_reference_id'],
            'created_by' => Auth::user()->id,
            'task_code' =>  $code
        ];
        $task = Task::create($task_params);

//        For Email ,,, type,department,category value filter
        if ($request->department_ids == null){
            $request->department_ids = [];
        }
        if ($request->category_ids == null){
            $request->category_ids = [];
        }
        if ($request->type_ids == null){
            $request->type_ids = [];
        }
        if ($request->user_ids == null){
            $request->user_ids = [];
        }
        $departments_ids = $request->department_ids;
        $category_ids = $request->category_ids;
        $type_ids = $request->type_ids;
        $user_ids = $request->user_ids;

        // select user department,type,category wise
        $staff = Staff::whereHas('departments', function (Builder $query) use ($departments_ids) {
            $query->whereIn('department_id',$departments_ids);
        })->orWhereHas('categories', function (Builder $query) use ($category_ids) {
            $query->whereIn('category_id',$category_ids);
        })->orWhereHas('types', function (Builder $query) use ($type_ids) {
            $query->whereIn('type_id',$type_ids);
        })->pluck('user_id');

        // assign users
        $emails = User::whereIn('id',$staff)->orWhereIn('id',$user_ids)->pluck('email');

        //email data
        $taskEmailData = Task::where('task_details_id',$taskDetails->id)->with('get_taskdetails','taskdetails','started_by','created_by_name')->first();

        //send Mail
        Mail::to($emails)->send(new TaskNotification($taskEmailData));

        if ($data['task_reference_type'] == 'General'){
            if ($request->index == null){
                return redirect()->back()->with('message', 'Task Created Successfully');
            }else{
                return Redirect::route('tasks.index')->with('message', 'Task Created Successfully.');
            }
        }else{
            return redirect()->back()->with('message', 'Task Created Successfully');
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
        $data = Task::where('id',$id)->first();
        $data['taskDetails'] = TaskDetails::where('id',$data->task_details_id)->with('users', 'departments', 'categories', 'types')->first();

        if ($data->task_reference_type == 'Form Submission' or $data->task_reference_type == 'Form Response'){
            $data['formResponse'] = FormResponse::where('id',$data->task_reference_id)->with('form')->first();
        }
        if ($data->task_reference_type == 'Form'){
            $data['form'] = Form::where('id',$data->task_reference_id)->first();
        }
        if ($data->task_reference_type == 'Report'){
            $data['report'] = Report::where('id',$data->task_reference_id)->first();
        }

        $data['organizations'] = Organization::all();
        $data['all_departments'] = Department::all();
        $data['all_categories'] = Category::all();
        $data['all_types'] = Type::all();
        $data['all_users'] = User::all();


        return Inertia::render('task/view', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $task = Task::where('id',$id)->first();
//        dd($task);
        $data = TaskDetails::where('id',$task->task_details_id)->with('users', 'departments', 'categories', 'types')->first();
        $data['task_id'] = $task->id;
        $data['task_status'] = $task->task_status;
        $data['started_by_id'] = $task->started_by_id;
        $data['end_time'] = $task->end_time;
        $data['user_id'] = Auth::user()->id;

        $data['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $data['organizations'] = Organization::all();
        } else {
            $data['organization_id'] = $data->organization_id;
        }

        return Inertia::render('task/edit', ['data' => $data]);
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
//        dd($request->all());
        Validator::make($request->all(), [
            'name' => ['required'],
            'due_date' => ['required'],
            'instruction' => ['required'],
            'organization_id' => ['required']
        ])->validate();

        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;

        $taskDetails = TaskDetails::find($id);
        $taskDetails->update($data);

        $taskDetails->departments()->sync($request->department_ids);
        $taskDetails->categories()->sync($request->category_ids);
        $taskDetails->types()->sync($request->type_ids);
        $taskDetails->users()->sync($request->user_ids);

        $task = Task::where('task_details_id',$id)->first();

        $task_id = $task->id;

        if ($data['task_status'] == 'CLOSE'){
            $data['status']= 'COMPLETED';
            if ($data['started_by_id'] == null){
                $data['started_by_id'] = Auth::user()->id;
            }
            if ($data['end_time'] == null){
                $data['end_time']= Carbon::now()->format('Y-m-d H:i:s');
            }
        }else{
            if ($data['started_by_id'] == null){
                $data['status']= 'PENDING';
                $data['end_time']= null;
            }else{
                $data['status']= 'ACCEPTED';
                $data['end_time']= null;
            }

        }

        $task_params = [
            'due_date' =>  $data['due_date'],
            'task_status' =>  $data['task_status'],
            'started_by_id' =>  $data['started_by_id'],
            'status' =>  $data['status'],
            'end_time' =>  $data['end_time']
        ];
        $task->update($task_params);

        // For Email ,,, type,department,category value filter
        if ($request->department_ids == null){
            $request->department_ids = [];
        }
        if ($request->category_ids == null){
            $request->category_ids = [];
        }
        if ($request->type_ids == null){
            $request->type_ids = [];
        }
        if ($request->user_ids == null){
            $request->user_ids = [];
        }
        $departments_ids = $request->department_ids;
        $category_ids = $request->category_ids;
        $type_ids = $request->type_ids;
        $user_ids = $request->user_ids;

        // select user department,type,category wise
        $staff = Staff::whereHas('departments', function (Builder $query) use ($departments_ids) {
            $query->whereIn('department_id',$departments_ids);
        })->orWhereHas('categories', function (Builder $query) use ($category_ids) {
            $query->whereIn('category_id',$category_ids);
        })->orWhereHas('types', function (Builder $query) use ($type_ids) {
            $query->whereIn('type_id',$type_ids);
        })->pluck('user_id');

        // assign users
        $emails = User::whereIn('id',$staff)->orWhereIn('id',$user_ids)->pluck('email');

        //email data
        $taskEmailData = Task::where('task_details_id',$id)->with('get_taskdetails','taskdetails','started_by','created_by_name')->first();

        //send Mail
        Mail::to($emails)->send(new TaskNotification($taskEmailData));

        return Redirect::route('tasks.show',$task_id)->with('message', 'Tasks Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $task = Task::where([
            'id' => $id,
        ])->first();
        TaskDetails::where('id',$task->task_details_id)->delete();
        $task->delete();

        return redirect()->back()->with('message', 'Tasks Deleted Successfully.');
    }

    //    Tasks Show Dashboard
    public function taskDashboard(){
        $task_ids = Task::where('user_id', Auth::user()->id)->pluck('form_id');
        $data = FormResponse::whereIn('form_id', $task_ids)
//            ->where('is_approved', 0)
            ->with('form.category')->get();
        return response()->json($data,200);
    }

    //startNow
    public function startNow($id){
        $task = Task::find($id);
        $data['status']= 'ACCEPTED';
//        $staff = Staff::where('user_id',Auth::user()->id)->first();
        $data['started_by_id']= Auth::user()->id;
        $data['start_time']= Carbon::now()->format('Y-m-d H:i:s');
        $task->update($data);
        return redirect()->back()->with('message', 'Task Started Successfully.');
    }

    //changeStatus
    public function changeStatus(Request $request)
    {
        $data = $request->all();
        if ($data['task_status'] == 'CLOSE'){
            $data['status']= 'COMPLETED';
            $data['end_time']= Carbon::now()->format('Y-m-d H:i:s');
        }else{
            $data['status']= 'ACCEPTED';
//            $data['end_time']= null;
        }
//        $task = Task::find($data['id']);
        $task = Task::where('id',$data['id'])->with('get_taskdetails','taskdetails','started_by','created_by_name')->first();
        $task->update($data);

        if ($task->status == 'COMPLETED'){
            $user_ids = [
                0=> $task->created_by,
                1=> $task->started_by_id,

            ];
            // assign users pluck('email')
            $emails = User::whereIn('id',$user_ids)->pluck('email');

            //send Mail
            Mail::to($emails)->send(new TaskNotification($task));
        }

        return redirect()->back()->with('message', 'Status Updated Successfully.');
    }



}
