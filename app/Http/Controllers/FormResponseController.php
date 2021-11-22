<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\File;
use App\Mail\TaskNotification;
use App\Models\EditHistory;
use App\Models\FormAutomation;
use App\Models\FormSetting;
use App\Models\Staff;
use App\Models\Task;
use App\Models\TaskDetails;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use App\Models\Category;
use App\Models\Form;
use App\Models\Form_Fields;
use App\Models\FormResponse;
use App\Models\FormResponseField;
use App\Models\Organization;
use Auth;
use Session;
use Carbon\Carbon;
//use File;


class FormResponseController extends Controller
{

    public function index(Request $request)
    {
      $query = $request->query();
      $where = array();
      $where = $this->getQuery($where, $request);
      $uid = Auth::user()->id;
      $org = Organization::where('user_id',$uid)->first();
      if (!empty($org)) {
        $org_id = $org->id;
        $data = Category::where($where)->where('organization_id',$org_id)->latest()->get();
      }else{
        $data = Category::where($where)->with('organization')->latest()->get();
      }
      $param['query'] = $query;
      $param['data'] = $data;
      return Inertia::render('form_response/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $request)
    {
        $query = $request->query();
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'id') {
                $where = array_merge(array(['form_responses.id',   $query['search_text'] ]), $where);
            }

        }

        if (!empty($request->organization_id)) {
            $where = array_merge(array(['forms.organization_id', $request->organization_id]), $where);
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
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $data = $request->all();
        $data['slug'] = $request->slug;

        $response_by = Auth::user()?Auth::user()->id:0;
//        dd($response_by);

        $res = FormResponse::create([
          'form_id' => $data['id'],
//          'response_by' => '0',
            'response_by' => $response_by,
          'response_date' => date("Y-m-d"),
          'status' => '1'
        ]);
        $fields = $data['fields'];

      foreach ($fields as $field) {
        if ($field['field_type'] != 'heading' and $field['field_type'] != 'infobox') {
            // code...
            $response = isset($field['response_value'])?$field['response_value']:'';
            $field['response_value'] = $response;
            if($field['field_type'] == 'multiselect'){
                $string = '';
//                dd($field['response_value']);
                if (!empty($field['response_value'])){
                    foreach ($field['response_value'] as $value) {
                        $string .= $value . ',';
                    }
                }

                $string = rtrim($string,',');
                $field['response_value'] = $string;
            }

            if ($data['iframe'] ==true ){
                if($field['field_type'] == 'fileupload'){
                    if (!empty($field['response_value'])){

                        $base64_str = substr($field['response_value'], strpos($field['response_value'], ",")+1);
                        $file = base64_decode($base64_str);
                        $folderName = 'public/uploads/form';
                        $safeName =  time().'.'.$request->file_extension;
                        $destinationPath = public_path() . $folderName;
                        $success = file_put_contents(public_path().'/uploads/form/'.$safeName, $file);

                        $file_url = '/public/uploads/form/'.$safeName;
                        $field['response_value'] = $file_url;
                    }

                }
            }

            $ans = FormResponseField::create([
              'form_id' => $data['id'],
              'form_field_id' => $field['id'],
              'form_response_id' => $res['id'],
              'response_value' => $field['response_value']

            ]);
        }
      }

        $setting = FormSetting::where('form_id', $data['id'])->first();

        if($setting->form_automation_id){
            $automation = FormAutomation::where('id', $setting->form_automation_id)->first();
            $departments_ids = $automation->departments->pluck('id');
            $category_ids = $automation->categories->pluck('id');
            $type_ids = $automation->types->pluck('id');
            $user_ids = $automation->users->pluck('id');

            $due_date = Carbon::now()->addHours($automation->due_date);
            $task_code = mt_rand(100, 999);
            $name = $automation->name;
            $task_name = $name .' '.'#'. $task_code;

            $task_details_params = [
                'name' => $task_name,
                'instruction' => $automation->instruction,
                'due_date' => $due_date,
                'organization_id' => $automation->organization_id,
                'created_by' => $automation->created_by,
            ];

            $taskdeatails = TaskDetails::create($task_details_params);

            $taskdeatails->departments()->sync($departments_ids);
            $taskdeatails->categories()->sync($category_ids);
            $taskdeatails->types()->sync($type_ids);
            $taskdeatails->users()->sync($user_ids);



            $task_params = [
                'task_details_id' => $taskdeatails->id,
                'task_type' => 'AUTOMATED',
                'due_date' => $due_date,
                'task_reference_type' => 'Form Submission',
                'task_reference_id' => $res['id'],
                'created_by' => $automation->created_by,
                'automation_id' => $setting->form_automation_id,
                'task_code' => $task_code
            ];

            $task = Task::create($task_params);

            // For Email ,,, type,department,category value filter
            if ($departments_ids == null){
                $departments_ids = [];
            }
            if ($category_ids == null){
                $category_ids = [];
            }
            if ($type_ids == null){
                $type_ids = [];
            }
            if ($user_ids == null){
                $user_ids = [];
            }

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
            $taskEmailData = Task::where('task_details_id',$taskdeatails->id)->with('get_taskdetails','taskdetails','started_by','created_by_name')->first();

            //send Mail
//            Mail::to($emails)->send(new TaskNotification($taskEmailData));

        }

        if ($data['iframe'] ==true ){
            return redirect()->route('forms.responses', ['slug'=>$request->slug,'view'=>'true'])->with('message', 'Data Submitted Successfully.');
        }else{
            return redirect()->route('forms.responses', ['slug'=>$request->slug])->with('message', 'Data Submitted Successfully.');
        }


    }
    public function success(Request $request,$slug){

        $data['slug'] ='';

        if (isset($request->view)){
            return Inertia::render('form_response/iframe_success', ['data' => $data]);
        }else{
            return Inertia::render('form_response/success', ['data' => $data]);
        }


    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request,$id)
    {

        $query = $request->query();
        if (!empty($request->from_date) && !empty($request->to_date)){
            $data['response'] = FormResponse::whereBetween('created_at', [$request->from_date, $request->to_date])
            ->where('form_id',$id)
                ->with('response.fields')
                ->latest()
                ->paginate(10)
                ->appends($query);
        }else{
            $data['response'] = FormResponse::where('form_id',$id)
                ->with('response.fields')
                ->latest()
                ->paginate(10)
                ->appends($query);
        }

        $data['form'] = Form::find($id);
        $data['field_title'] = Form_Fields::where('form_id', $id)->orderBy('field_order', 'asc')->get();
        $data['responses_field'] = Form_Fields::where('form_id', $id)->with('get_responses_form_field')->orderBy('field_order', 'asc')->get();
        $data['query'] = $query;

        // Create task
        $data['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $data['organizations'] = Organization::all();
        } else {
            $data['organization_id'] = Auth::user()->organization_id;

        }

        return Inertia::render('form_response/index', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $task_Submission = Task::where([
            'task_reference_id' => $id,
            'task_reference_type' => 'Form Submission',
        ])->count();

        $task_Response = Task::where([
            'task_reference_id' => $id,
            'task_reference_type' => 'Form Response',
        ])->count();

        if ($task_Submission > 0 or $task_Response > 0){
            return redirect()->back()->with('message', 'You can not delete this data.');
        }
        else{
            $formResposeField = FormResponseField::with('fields')->where('form_response_id',$id)->get();

            foreach ($formResposeField as $value){
                if ($value->fields->field_type == 'fileupload'){
                    $dataPath = $value->response_value;
                    $filename = substr($dataPath, strpos($dataPath, "form/") + 5);
                    File::delete(public_path("uploads/form/".$filename));
                }
                $value->delete();
            }


            $formResponse = FormResponse::find($id)->delete();
            return redirect()->back()->with('message', 'Data Deleted Successfully.');
        }

    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function response($slug)
    {
        $data =  Form::where('slug', $slug)->with('formSetting')->first();

        if ($data->formSetting == null){
            $data['title'] = $data['Form_title'];
            $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
            return Inertia::render('form_response/edit', ['data' => $data]);
        }else{
            if ($data->formSetting->is_public == 1){
                if(!empty($data->formSetting->password)){
                    // $data = Form::where('slug',$slug)->first();
                    $data['is_password'] = $data->formSetting->password;
                    $data['form_setting_id'] = $data->formSetting->id;
                    $data['title'] = $data['Form_title'];
                    $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                    return Inertia::render('form_response/edit', ['data' => $data]);
                }else{
                    // $data = Form::where('slug',$slug)->first();
                    $data['title'] = $data['Form_title'];
                    $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                    return Inertia::render('form_response/edit', ['data' => $data]);
                }
            }else{
                if(!empty(Auth::user()->id)){
                    if(!empty($data->formSetting->password)){
                        // $data = Form::where('slug',$slug)->first();
                        $data['is_password'] = $data->formSetting->password;
                        $data['form_setting_id'] = $data->formSetting->id;
                        $data['title'] = $data['Form_title'];
                        $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                        return Inertia::render('form_response/edit', ['data' => $data]);
                    }else{
                        // $data = Form::where('slug',$slug)->first();
                        $data['title'] = $data['Form_title'];
                        $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                        return Inertia::render('form_response/edit', ['data' => $data]);
                    }
                }else{
                    // return redirect()->route('login');
                    //return Request::settion->get('url.indent') ?? 'login';
                    if(!session()->has('url.intended'))
                    {
                        session(['url.intended' => url()->previous()]);
                    }

                    return redirect()->route('login');
                }
            }
        }


    }

//iframe
    public function iframe($slug)
    {
        $data =  Form::where('slug', $slug)->with('formSetting')->first();

        if ($data->formSetting == null){
            $data['title'] = $data['Form_title'];
            $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
            return Inertia::render('form_response/iframe', ['data' => $data]);
        }else{
            if ($data->formSetting->is_public == 1){
                if(!empty($data->formSetting->password)){
                    // $data = Form::where('slug',$slug)->first();
                    $data['is_password'] = $data->formSetting->password;
                    $data['form_setting_id'] = $data->formSetting->id;
                    $data['title'] = $data['Form_title'];
                    $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                    return Inertia::render('form_response/iframe', ['data' => $data]);
                }else{
                    // $data = Form::where('slug',$slug)->first();
                    $data['title'] = $data['Form_title'];
                    $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                    return Inertia::render('form_response/iframe', ['data' => $data]);
                }
            }else{
                if(!empty(Auth::user()->id)){
                    if(!empty($data->formSetting->password)){
                        // $data = Form::where('slug',$slug)->first();
                        $data['is_password'] = $data->formSetting->password;
                        $data['form_setting_id'] = $data->formSetting->id;
                        $data['title'] = $data['Form_title'];
                        $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                        return Inertia::render('form_response/iframe', ['data' => $data]);
                    }else{
                        // $data = Form::where('slug',$slug)->first();
                        $data['title'] = $data['Form_title'];
                        $data['fields'] = Form_Fields::where('form_id',$data['id'])->with('options')->orderBy('field_order', 'asc')->get();
                        return Inertia::render('form_response/iframe', ['data' => $data]);
                    }
                }else{
                    // return redirect()->route('login');
                    //return Request::settion->get('url.indent') ?? 'login';
                    if(!session()->has('url.intended'))
                    {
                        session(['url.intended' => url()->previous()]);
                    }

                    return redirect()->route('login');
                }
            }
        }


    }

    //Submission form Protected
    public function protectForm(Request $request){

        $check = FormSetting::find($request->id);
        if($check->password == $request->password){
             return response()->json(['status'=> 200]);
        }else{
            return response()->json(['status'=> 400]);
        }
    }


    public function viewData(Request $request)
    {
        $data = FormResponse::where('id',$request->response_id)->with('form', 'response.fields')->first();
        $data['edit_histories'] = EditHistory::where('form_response_id',$request->response_id)
            ->with('form', 'form_response','from_department','user')
            ->latest()
            ->get();

        $data['last_edit'] = EditHistory::where('form_response_id',$request->response_id)
            ->orderBy('updated_at','DESC')
            ->with('form', 'form_response','from_department','user')
            ->first();

//        $data['fields'] = Form_Fields::where('form_id',$data->form_id)->orderBy('field_order', 'asc')->get();
        return Inertia::render('form_response/viewData', ['data' => $data]);
    }


    public function submissionData(Request $request)
    {
        $data = FormResponse::where('id',$request->response_id)->with('form', 'response_by_name','response.fields')->first();
        $data['edit_histories'] = EditHistory::where('form_response_id',$request->response_id)
            ->with('form','get_response_by_name', 'form_response','user')
            ->latest()
            ->get();

        $data['last_edit'] = EditHistory::where('form_response_id',$request->response_id)
            ->orderBy('updated_at','DESC')
            ->with('form', 'form_response','get_response_by_name','user')
            ->first();

        //dd($data);

        return Inertia::render('form_response/submissionData', ['data' => $data]);
    }

    public function editData(Request $request)
    {
        $data = FormResponse::where('id',$request->response_id)->with('form', 'response.fields.options')->first();

        $fields = array();
        foreach ($data->response as $key => $value){
            $field = $value->fields;
            $field['response_value'] = $value->response_value;
            $field['response_id'] = $value->id;
            array_push($fields, $field);
        }
        $data['fields'] = $fields;
        $data['query'] = $query = $request->query();


        return Inertia::render('form_response/editData', ['data' => $data]);
    }


    public function updateData(Request $request)
    {
        $form_response_id =$request->id;
        $data = $request->fields;
//        dd($data);
        $fields = $data;
        $id = $request->form_id;

        foreach ($fields as $field) {

            if($field['field_type'] == 'multiselect'){
                $string = '';
                foreach ($field['response_value'] as $value) {
                    $string .= $value . ',';
                }
                $string = rtrim($string,',');
                $string = ltrim($string, ',');
                $field['response_value'] = $string;
            }

           FormResponseField::where('id', $field['response_id'])->update([
                'response_value' => $field['response_value']
            ]);

        }

        $editHistory = EditHistory::create([
            'form_id' =>$id,
            'form_response_id' => $form_response_id,
            'user_id' => Auth::user()->id
        ]);

        return redirect()->route('submissionData', ['response_id' => $form_response_id])->with('message', 'Data Updated Successfully.');

    }


    public function changeStatus(Request $request)
    {
        $data = $request->all();
        $form_response = FormResponse::where('id', $data['id'])->update([
            'is_approved' => $data['is_approved']
        ]);
        return redirect()->back()->with('message', 'Status Updated Successfully.');
    }


    // form response file upload
    public function fileUpload(Request $request){
//        dd($request->all());
        $fileName = time().'.'.$request->attachment->extension();
        $request->attachment->move(public_path('uploads/form'), $fileName);

        $file_url = '/public/uploads/form/'.$fileName;

        return response()->json(['url' => $file_url, 'status' => 'success'], 200);
    }
}
