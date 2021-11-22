<?php

namespace App\Http\Controllers;

use App\Mail\ReportPreview;
use App\Mail\TaskNotification;
use App\Models\Category;
use App\Models\Department;
use App\Models\Form;
use App\Models\Form_Fields;
use App\Models\FormResponse;
use App\Models\FormResponseField;
use App\Models\ReportAutomationHistory;
use App\Models\ReportDataRepresentation;
use App\Models\Staff;
use App\Models\Type;
use App\Models\MailSetting;
use App\Models\Organization;
use App\Models\Report;
use App\Models\reportDataFilter;
use App\Models\reportDateFilter;
use App\Models\User;
//use Barryvdh\DomPDF\PDF;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Inertia\Inertia;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Barryvdh\DomPDF\Facade as PDF;


class ReportController extends Controller
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
        $data = Report::where($where)->with( 'created_by_user','organization','departments', 'categories', 'types')->latest();

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($request->except('organization_id','access'));
        $param['query'] = $query;
        $param['data'] = $data;

        // Create task
        $param['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $param['organizations'] = Organization::all();
        } else {
            $param['organization_id'] = Auth::user()->organization_id;
        }

        return Inertia::render('Report/index',['data' => $param]);
       }

    //Report Automation
    public function reportAutomationIndex(Request $request)
    {
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $request);
        $data = Report::where($where)->with( 'created_by_user','organization','departments', 'categories', 'types')->latest();

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($request->except('organization_id','access'));
        $param['query'] = $query;
        $param['data'] = $data;

        return Inertia::render('Report/auto_index',['data' => $param]);
       }



    // filtering by department,category,type,user
    public function search($data, $request){
        $data = $data->whereHas('categories', function($q) use($request){
            $q->where('name', $request->search_text);
        })->orWhereHas('departments', function($q) use($request){
            $q->where('name', $request->search_text);
        })->orWhereHas('types', function($q) use($request){
            $q->where('name', $request->search_text);
        });

        return $data;

    }

    // search query builder
    public function getQuery($where, $request)
    {
//        dd($request->path());
        $query = $request->query();
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['reports.report_name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            if ($query['search_type'] == 'report_type') {
                if(str_contains('Compare compare COMPARE',$query['search_text'])){
                    $report_type = 'COMPARE';
                }
                elseif(str_contains('Single single SINGLE',$query['search_text'])){
                    $report_type = 'SINGLE';
                }
                else{
                    $report_type = $query['search_text'];
                }
                $where = array_merge(array(['reports.type', $report_type]), $where);

            }

            if ($query['search_type'] == 'created_by') {
                $created_by = User::where('name', 'LIKE', '%' . $query['search_text'] . '%')->first();
                $where = array_merge(array(['reports.created_by', $created_by->id]), $where);
            }
        }

        if (!empty($request->organization_id)){
            $where = array_merge(array(['reports.organization_id', $request->organization_id]), $where);
        }
        if ($request->path() == 'report-automation'){
            $where = array_merge(array(['reports.is_for_automation', 'YES']), $where);
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
        //dd($request->all());
        Validator::make($request->all(), [
            'report_name' => ['required'],
            'description' => ['required'],
            'form_id' => ['required'],
            'organization_id' => ['required']
        ])->validate();


        $data = $request->all();
        $data['slug'] = sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
        $data['created_by'] = Auth::user()->id;

        $form = Report::create($data);
        // create many to many table data
        $form->departments()->sync($request->department_ids);
        $form->categories()->sync($request->category_ids);
        $form->types()->sync($request->type_ids);
        return redirect()->route('reports.dataRepresentation');
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
            'report_name' => ['required'],
            'description' => ['required'],
            'form_id' => ['required'],
            'category_id' => ['required'],
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();


        $data = $request->all();
        $data['slug'] = sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
        $data['created_by'] = Auth::user()->id;
        $data['is_for_automation'] = $request->is_for_automation;
//        $data['duration'] = $request->duration;
        $data['interval'] = $request->interval;
        $data['last_running_time'] = $request->last_running_time;

//        if ($data['is_for_automation'] == 'YES'){
//            $data['last_running_time'] = Carbon::now();
//        }

        $form = Report::create($data);
        // create many to many table data
        $form->departments()->sync($request->department_ids);
        $form->categories()->sync($request->category_ids);
        $form->types()->sync($request->type_ids);
        return redirect()->route('reports.dataRepresentation',['slug' => $form->slug]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($slug)
    {
        $data = Report::where('slug', $slug)->with( 'departments', 'categories', 'types')->first();

        $data['step'] = 'one';
        $data['edit'] = 'yes';
        $data['mode'] = 'edit';

        $category_id = $data->category_id;
        $data['all_forms'] = Form::whereHas('categories', function($q) use ($category_id){
            $q->where('category_id', $category_id);
        })->get();

        $data['user_type'] = Auth::user()->user_type;
        if ($data['user_type'] =='admin'){

            $data['organizations'] = Organization::get();
            $data['all_departments'] = Department::all();
            $data['all_categories'] = Category::all();
            $data['all_types'] = Type::all();
        }else{
            $data['organization_id'] = Auth::user()->organization_id;
            $data['all_departments'] = Department::where('organization_id', $data['organization_id'])->get();
            $data['all_categories'] = Category::where('organization_id', $data['organization_id'])->get();
            $data['all_types'] = Type::where('organization_id', $data['organization_id'])->get();
        }

        return Inertia::render('Report/generate', ['data'=>$data]);
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
            'report_name' => ['required'],
            'description' => ['required'],
            'form_id' => ['required'],
            'category_id' => ['required'],
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;

        $representation = ReportDataRepresentation::where('report_id',$id)->first();
        $data_filter = reportDataFilter::where('report_id',$id)->get();
        $date_filter = reportDateFilter::where('report_id',$id)->get();

        // Update Form for data representation
        if ($representation != null){
            if ($representation->form_id != $data['form_id']){
                $representation->update([
                    'form_field_id' => '[]'
                ]);
            }
        }

        // remove data filter for updated Form
        if ($data_filter != null){
            foreach ($data_filter as $filter){
                if ($filter->form_id != $data['form_id']){
                    $filter->delete();
                }
            }
        }

        // remove date filter for updated Form
        if ($date_filter != null){
            foreach ($date_filter as $filter){
                if ($filter->form_id != $data['form_id']){
                    $filter->delete();
                }
            }
        }


        $form = Report::find($id);
        $form->update($data);

        // create many to many table data
        $form->departments()->sync($request->department_ids);
        $form->categories()->sync($request->category_ids);
        $form->types()->sync($request->type_ids);
        return redirect()->route('reports.dataRepresentation',['slug' => $form->slug]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Report::where('id',$id)->delete();
        ReportDataRepresentation::where('report_id',$id)->delete();
        reportDateFilter::where('report_id', $id)->delete();
        reportDataFilter::where('report_id', $id)->delete();
        return redirect()->back()->with('message', 'Report Deleted Successfully.');

    }
    //step one
    public function generate(Request $request){
        $data['step'] = 'one';

        $data['is_for_automation'] = isset($request->is_for_automation)?$request->is_for_automation: 'NO';
//        $data['duration'] = isset($request->duration)?$request->duration: null;
        $data['interval'] = isset($request->interval)?$request->interval: null;
        $data['last_running_time'] = isset($request->last_running_time)?$request->last_running_time: null;


        $data['user_type'] = Auth::user()->user_type;
        if ($data['user_type'] =='admin'){
            $data['all_categories'] = Category::get();
            $data['organizations'] = Organization::get();
        }else{
            $data['organization_id'] = $request->organization_id;
            $data['all_categories'] = Category::where('organization_id',$data['organization_id'])->get();
        }

        return Inertia::render('Report/generate', ['data'=>$data]);
    }


    //Get Category Api
    public function getCategory($id){
       $data['all_forms'] = Form::whereHas('categories', function($q) use ($id){
            $q->where('category_id', $id);
        })->get();
        return response()->json($data, Response::HTTP_OK);
    }

    //step Two
    public function dataRepresentation($slug){
        $data['step'] = 'two';
//        $data['edit'] = 'no';

        $data['report'] = Report::where('slug', $slug)->first();
        $reportData = ReportDataRepresentation::where('report_id', $data['report']->id)->first();

        if ($reportData){
            $data['edit'] = 'yes';
            $data['reportData'] = $reportData;
            $data['selected_fields'] = Form_Fields::whereIn('id',json_decode($reportData->form_field_id))->get();
            $data['form_fields'] = Form_Fields::where([
                'form_id' => $data['report']->form_id,
                'field_type' => 'number'
            ])->whereNotIn('id',json_decode($reportData->form_field_id))->get();

        }else{
            $data['form_fields'] = Form_Fields::where([
                'form_id' => $data['report']->form_id,
                'field_type' => 'number'
            ])->get();

        }

       return Inertia::render('Report/generate', ['data'=>$data]);
    }

    // step two data_store
    public function data_store(Request $request){
        Validator::make($request->all(), [
            'form_field_id' => ['required'],
        ])->validate();
        $data = $request->all();
        $data['form_field_id'] = json_encode($request->form_field_id);
        $data['created_by'] = Auth::user()->id;

        $report = Report::where('slug', $request->report_slug)->first();
        $rep = ReportDataRepresentation::where('report_id', $report->id)->first();

        if ($rep){
            $rep->update($data);
        }else{
            ReportDataRepresentation::create($data);
        }
        return redirect()->route('reports.filter', ['report_slug' => $request->report_slug]);
    }

    //step three
    public function filter($slug){

        $data['step'] = 'three';
        $data['slug'] = $slug;
        $data['report'] = Report::where('slug', $slug)->first();
        $data['reportType'] = $data['report']->type;
        $form_id = $data['report']->form_id;
        $reportId = $data['report']->id;
        $getField = Form_Fields::where('form_id', $form_id)->orWhere('form_id', 0)->get();
        $repDate = reportDateFilter::where('report_id', $reportId)->first();
        $repData = reportDataFilter::where('report_id', $reportId)->first();

        $getResponse = FormResponse::where('form_id', $form_id)->count();

        $data['typeDate'] = [];
        $data['typeData'] = [];

//        if ($getResponse > 0){
//
//        }
        $add_response_date_field = [
            "id" => $form_id,
            "form_id" => $form_id,
            "field_type" => "date",
            "field_label" => "response_date",
            "field_name" => "Created at",
            "field_placeholder" => "response_date",
            "field_default_value" => null,
        ];
        array_push($data['typeDate'], $add_response_date_field);

        foreach($getField as $value){
             if ($value->field_type == 'date') {
                 array_push($data['typeDate'], $value);
             }elseif ($value->field_type == 'number' or $value->field_type == 'text' or $value->field_type == 'currency'){
                array_push($data['typeData'], $value);
             }
        }

//        dd( $data['typeDate']);

        if (!empty($repDate || $repData)) {
                $data['edit'] = 'yes';
                $data['repDate'] = reportDateFilter::where('report_id', $reportId)->get();
                $data['repData'] = reportDataFilter::where('report_id', $reportId)->get();
        }
        return Inertia::render('Report/generate', ['data'=>$data]);
    }
    public function filterStore(Request $request , $slug){
//dd($request->all());
       if($request->report_type == "SINGLE"){
        Validator::make($request->all(), [
            'dateField' => ['required']
        ])->validate();
       }
       if($request->report_type == "COMPARE"){
        Validator::make($request->all(), [
            'dateField' => ['required'],
            'dateField2' => ['required'],
        ])->validate();
       }

       if($request->dateField){
        Validator::make($request->all(), [
            'startDate' => ['required'],
            'endDate' => ['required'],
        ])->validate();
       }
       if($request->dataField){
        Validator::make($request->all(), [
            'compare_op' => ['required'],
            'input' => ['required'],
        ])->validate();
       }
       if($request->dateField2){
        Validator::make($request->all(), [
            'startDate2' => ['required'],
            'endDate2' => ['required'],
        ])->validate();
       }
       if($request->dataField2){
        Validator::make($request->all(), [
            'compare_op2' => ['required'],
            'input2' => ['required'],
        ])->validate();
       }

        $data = $request->all();
        $data =  Report::where('slug', $slug)->first();
        $reportId = $data->id;
        $formId = $data->form_id;
        $data['step'] = 'four';

       $checkDate1 = reportDateFilter::where('report_id', $reportId)->where('filter_type', 1)->first();
       $checkData1 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 1)->first();

       $checkDate2 = reportDateFilter::where('report_id', $reportId)->where('filter_type', 2)->first();
       $checkData2 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 2)->first();




    //    if(!empty($checkDate1) or !empty($checkDate2)){
            if(!empty($request->dateField) && !empty($checkDate1->id) ){
               // dd('update');
              // dd($request->all());
               // return $formId;
                $checkDate1->filter_type;
                $checkDate1->where('filter_type', '1')->where('id', $checkDate1->id)->update([
                    'report_id' => $reportId,
                    'form_id' => $formId,
                    'form__fields_id'=> $request->dateField,
                    'start_date' => $request->startDate,
                    'end_date' => $request->endDate,
                    'updated_by' => Auth::user()->id
                ]);
            }else{
               // dd('create');
                if(!empty($request->dateField)){
                    reportDateFilter::create([
                        'report_id' => $reportId,
                        'form_id' => $formId,
                        'form__fields_id'=> $request->dateField,
                        'start_date' => $request->startDate,
                        'end_date' => $request->endDate,
                        'created_by' => Auth::user()->id
                    ]);
                }

            }

            if(!empty($request->dataField) && !empty($checkData1->id) ){
                $checkData1->where('filter_type', '1')->where('id', $checkData1->id)->update([
                    'report_id' => $reportId,
                    'form_id' => $formId,
                    'form__fields_id'=> $request->dataField,
                    'compare_operator' => $request->compare_op,
                    'compare_value' => $request->input,
                    'updated_by' => Auth::user()->id
                ]);

            }else{
                if(!empty($request->dataField)){
                    reportDataFilter::create([
                        'report_id' => $reportId,
                        'form_id' => $formId,
                        'form__fields_id'=> $request->dataField,
                        'compare_operator' => $request->compare_op,
                        'compare_value' => $request->input,
                        'created_by' => Auth::user()->id
                    ]);
                }

            }


            if($request->report_type == 'COMPARE'){

                if(!empty($request->dateField2) && !empty($checkDate2->id)){
                    $checkDate2->where('filter_type', '2')->where('id', $checkDate2->id)->update([
                        'report_id' => $reportId,
                        'form_id' => $formId,
                        'form__fields_id'=> $request->dateField2,
                        'start_date' => $request->startDate2,
                        'end_date' => $request->endDate2,
                        'filter_type' => 2,
                        'updated_by' => Auth::user()->id


                    ]);
                }else{
                    if(!empty($request->dateField2)){
                        reportDateFilter::create([
                            'report_id' => $reportId,
                            'form_id' => $formId,
                            'form__fields_id'=> $request->dateField2,
                            'start_date' => $request->startDate2,
                            'end_date' => $request->endDate2,
                            'filter_type' => 2,
                            'created_by' => Auth::user()->id
                        ]);
                    }

                }

                if(!empty($request->dataField2) && !empty($checkData2->id)){
                        $checkData2->where('filter_type', '2')->where('id', $checkData2->id)->update([
                            'report_id' => $reportId,
                            'form_id' => $formId,
                            'form__fields_id'=> $request->dataField2,
                            'compare_operator' => $request->compare_op2,
                            'compare_value' => $request->input2,
                            'filter_type' => 2,
                            'updated_by' => Auth::user()->id
                        ]);
                    }else{
                     //  return $request->dataField2;
                     if(!empty($request->dataField2)){

                        reportDataFilter::create([
                            'report_id' => $reportId,
                            'form_id' => $formId,
                            'form__fields_id'=> $request->dataField2,
                            'compare_operator' => $request->compare_op2,
                            'compare_value' => $request->input2,
                            'filter_type' => 2,
                            'updated_by' => Auth::user()->id
                        ]);
                     }

                    }
            }

        return redirect()->route('reports.preview', ['slug'=>$slug]);

    }

    public function preview(Request $request , $slug){

        $report =  Report::where('slug', $slug)->with( 'created_by_user','organization','departments', 'categories', 'types')->first();
        $reportId = $report->id;
        $formId = $report->form_id;
        $data['step'] = 'four';
        $data['viewToPreview'] = isset($request->view)?$request->view:null;
//        dd( $data['viewToPreview']);
        $filtered_response_result_2 = [];

        $report_data_representation = ReportDataRepresentation::where('report_id', $report->id)->first();

        if ($report_data_representation == null){
            $jsonobj = '{"form_field_id":[],"Ben":37,"Joe":43}';
            $report_data_representation = $jsonobj;
            $report_data_representation = json_decode($report_data_representation);
            $report_data_representation->form_field_id = '[]';
        }

        //********************* Query for single report type ****************************
        $date_filter_1 = reportDateFilter::with('formsFields')->where('report_id', $reportId)->where('filter_type', 1)->first();
        $data_filter_1 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 1)->first();
        $response_ids = [];

        if($date_filter_1){

            if ($date_filter_1->form__fields_id == $formId && $date_filter_1->form_id == $formId){
                $response_ids = FormResponse::where('form_id', $formId)
                    ->whereBetween('response_date', [$date_filter_1->start_date, $date_filter_1->end_date])
                    ->pluck('id')
                    ->toArray();
            }else{
                $response_ids = FormResponseField::where('form_id', $formId)
                    ->whereBetween('response_value', [$date_filter_1->start_date, $date_filter_1->end_date])
                    ->where('form_field_id', $date_filter_1->form__fields_id)
                    ->pluck('form_response_id')
                    ->toArray();
            }
//            dd($response_ids);

//                $field = Form_Fields::where('id', $date_filter_1->form__fields_id)->first();
//
//                 $response_ids = FormResponseField::where('form_id', $formId);
//                 if($field->field_name == 'created_at'){
//                    $response_ids = $response_ids->whereBetween('created_at', [$date_filter_1->start_date, $date_filter_1->end_date]);
//                 }else{
//                    $response_ids = $response_ids->whereBetween('response_value', [$date_filter_1->start_date, $date_filter_1->end_date])
//                    ->where('form_field_id', $date_filter_1->form__fields_id);
//
//                 }
//                 $response_ids = $response_ids->pluck('form_response_id')
//                     ->toArray();

        }

        if($data_filter_1){

            if ($date_filter_1 != null){

                if (empty($response_ids)){

                    if ($date_filter_1->form__fields_id == $formId && $date_filter_1->form_id == $formId){
                        $response_ids = [];
                    }else{
                        $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                            ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                            ->where('form_field_id', $date_filter_1->form__fields_id)
                            ->whereBetween('response_value', [$date_filter_1->start_date, $date_filter_1->end_date])
                            ->pluck('form_response_id')
                            ->toArray();
                    }

                }else{
                    $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                        ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                        ->whereIn('form_response_id', $response_ids)
                        ->pluck('form_response_id')
                        ->toArray();
                }

            }else{
                if (empty($response_ids)){
                    $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                        ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                        ->pluck('form_response_id')
                        ->toArray();
                }
            }

//            if (empty($response_ids)){
//                $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
//                    ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
//                    ->pluck('form_response_id')
//                    ->toArray();
//            }else{
//                $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
//                    ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
//                    ->whereIn('form_response_id', $response_ids)
//                    ->pluck('form_response_id')
//                    ->toArray();
//            }

        }

        $filtered_response_result_1 = DB::table('form_response_fields')
            ->join('form__fields', 'form__fields.id', '=', 'form_response_fields.form_field_id')
            ->whereIn('form_field_id', json_decode($report_data_representation->form_field_id));

        if($date_filter_1 or $data_filter_1){
            $filtered_response_result_1 = $filtered_response_result_1->whereIn('form_response_id', $response_ids);
        }

//       return $filtered_response_result_1;
           $filtered_response_result_1 = $filtered_response_result_1->select(DB::raw('count(form_response_fields.response_value) as count,
            sum(form_response_fields.response_value) as sum, max(form_response_fields.response_value) as max,
              min(form_response_fields.response_value) as min, avg(form_response_fields.response_value) as avg, form__fields.field_label '))
            ->groupBy('form__fields.field_label')
            ->get();


       global $dateCheck;
        //********************* Query for compare report type ****************************
        if($report->type === 'COMPARE'){
             $data['report_type'] = 'COMPARE';
             $date_filter_2 = reportDateFilter::with('formsFields')->where('report_id', $reportId)->where('filter_type', 2)->first();
             $data_filter_2 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 2)->first();
             $response_ids = [];

             $data['date_2'] = $date_filter_2;

            if(!empty($date_filter_2->report_id)){
                $dateCheck = $date_filter_2->report_id;
            }

             if($date_filter_2){

                 if ($date_filter_2->form__fields_id == $formId && $date_filter_2->form_id == $formId){
                     $response_ids = FormResponse::where('form_id', $formId)
                         ->whereBetween('response_date', [$date_filter_2->start_date, $date_filter_2->end_date])
                         ->pluck('id')
                         ->toArray();

                 }else{
                     $response_ids = FormResponseField::where('form_id', $formId)
                         ->whereBetween('response_value', [$date_filter_2->start_date, $date_filter_2->end_date])
                         ->where('form_field_id', $date_filter_2->form__fields_id)
                         ->pluck('form_response_id')
                         ->toArray();
                 }

//                $field = Form_Fields::where('id', $date_filter_2->form__fields_id)->first();
//
//                 $response_ids = FormResponseField::where('form_id', $formId);
//                 if($field->field_name == 'created_at'){
//                    $response_ids = $response_ids->whereBetween('created_at', [$date_filter_2->start_date, $date_filter_2->end_date]);
//                 }else{
//                    $response_ids = $response_ids->whereBetween('response_value', [$date_filter_2->start_date, $date_filter_2->end_date])
//                    ->where('form_field_id', $date_filter_2->form__fields_id);
//                 }
//
//                 $response_ids = $response_ids->pluck('form_response_id')
//                     ->toArray();

             }


             if($data_filter_2){

                 if ($date_filter_2 != null){

                     if (empty($response_ids)){
                         if ($date_filter_2->form__fields_id == $formId && $date_filter_2->form_id == $formId){
                             $response_ids = [];
                         }else{
                             $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                                 ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                                 ->where('form_field_id', $date_filter_2->form__fields_id)
                                 ->whereBetween('response_value', [$date_filter_2->start_date, $date_filter_2->end_date])
                                 ->pluck('form_response_id')
                                 ->toArray();
                         }

                     }else{
                         $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                             ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                             ->whereIn('form_response_id', $response_ids)
                             ->pluck('form_response_id')
                             ->toArray();
                     }

                 }else{
                     if (empty($response_ids)){
                         $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                         ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                         ->pluck('form_response_id')
                         ->toArray();
                     }
                 }

//                 if (empty($response_ids)){
//                     $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
//                         ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
//                         ->pluck('form_response_id')
//                         ->toArray();
//                 }else{
//                     $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
//                         ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
//                         ->whereIn('form_response_id', $response_ids)
//                         ->pluck('form_response_id')
//                         ->toArray();
//                 }



//                 $filtered_response_2 = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
//                     ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value);
//
//                 if($response_ids){
//                     $filtered_response_2 = $filtered_response_2->whereIn('form_response_id', $response_ids);
//                 }
//
//                 $response_ids = $filtered_response_2->pluck('form_response_id')->toArray();

             }


            $filtered_response_result_2 = DB::table('form_response_fields')
                ->join('form__fields', 'form__fields.id', '=', 'form_response_fields.form_field_id')
                ->whereIn('form_field_id', json_decode($report_data_representation->form_field_id));

             if($date_filter_2 or $data_filter_2){
                 $filtered_response_result_2 = $filtered_response_result_2->whereIn('form_response_id', $response_ids);
             }

            $filtered_response_result_2 = $filtered_response_result_2->select(DB::raw('count(form_response_fields.response_value) as count,
            sum(form_response_fields.response_value) as sum, max(form_response_fields.response_value) as max,
              min(form_response_fields.response_value) as min, avg(form_response_fields.response_value) as avg,  form__fields.field_label '))
                ->groupBy('form__fields.field_label')
                ->get();

        }


        global $dateCheck1;

        $fields =  Form_Fields::whereIn('id', json_decode($report_data_representation->form_field_id))
        ->select(DB::raw('0 as count,0 as sum, 0 as max, 0 as min, 0 as avg,  form__fields.field_label '))
        ->groupBy('form__fields.field_label')
        ->get();

        //query parameter get when request get to view
        if( $request->has('view') ) {
            $data['view'] = true;
        }

        if (!empty($date_filter_1->report_id)) {
            $dateCheck1 =  $date_filter_1->report_id;
        }
        $filtered_response_result_two=[];
        if(!empty($filtered_response_result_2)){
            $filtered_response_result_two =  $filtered_response_result_2;
        }
        //***************** Finally return data to view *********************
        $data['date_1'] = $date_filter_1;


        $data['date_filter2_report_id_1'] = $dateCheck1;
        $data['date_filter2_report_id'] = $dateCheck;

        $data['report'] = $report;
        $data['representation'] = $report_data_representation;
        $data['form_one'] = count($filtered_response_result_1) >0 ? $filtered_response_result_1:$fields;
        $data['form_two'] = count($filtered_response_result_two) >0 ? $filtered_response_result_two:$fields;

        $total_form_one = 0;
        $total_form_two = 0;

        foreach ($data['form_one'] as $form_one){
            $total_form_one = $total_form_one + $form_one->count;
        }

        foreach ($data['form_two'] as $form_two){
            $total_form_two = $total_form_two + $form_two->count;
        }

        $data['total_records_form_one'] = $total_form_one;
        $data['total_records_form_two'] = $total_form_two;


        return Inertia::render('Report/generate', ['data'=>$data]);

    }

    //send email pdf
    public function send_email_pdf(Request $request , $slug){

        $report =  Report::where('slug', $slug)->with( 'created_by_user','organization','departments', 'categories', 'types')->first();
        $reportId = $report->id;
        $formId = $report->form_id;
        $data['step'] = 'four';
        $data['viewToPreview'] = isset($request->view)?$request->view:null;

        $filtered_response_result_2 = [];

        $report_data_representation = ReportDataRepresentation::where('report_id', $report->id)->first();

        if ($report_data_representation == null){
            $jsonobj = '{"form_field_id":[],"Ben":37,"Joe":43}';
            $report_data_representation = $jsonobj;
            $report_data_representation = json_decode($report_data_representation);
            $report_data_representation->form_field_id = '[]';
        }

        //********************* Query for single report type ****************************
        $date_filter_1 = reportDateFilter::with('formsFields')->where('report_id', $reportId)->where('filter_type', 1)->first();
        $data_filter_1 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 1)->first();
        $response_ids = [];

        if($date_filter_1){

            if ($date_filter_1->form__fields_id == $formId && $date_filter_1->form_id == $formId){
                $response_ids = FormResponse::where('form_id', $formId)
                    ->whereBetween('response_date', [$date_filter_1->start_date, $date_filter_1->end_date])
                    ->pluck('id')
                    ->toArray();
            }else{
                $response_ids = FormResponseField::where('form_id', $formId)
                    ->whereBetween('response_value', [$date_filter_1->start_date, $date_filter_1->end_date])
                    ->where('form_field_id', $date_filter_1->form__fields_id)
                    ->pluck('form_response_id')
                    ->toArray();
            }

        }

        if($data_filter_1){

            if ($date_filter_1 != null){

                if (empty($response_ids)){

                    if ($date_filter_1->form__fields_id == $formId && $date_filter_1->form_id == $formId){
                        $response_ids = [];
                    }else{
                        $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                            ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                            ->where('form_field_id', $date_filter_1->form__fields_id)
                            ->whereBetween('response_value', [$date_filter_1->start_date, $date_filter_1->end_date])
                            ->pluck('form_response_id')
                            ->toArray();
                    }

                }else{
                    $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                        ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                        ->whereIn('form_response_id', $response_ids)
                        ->pluck('form_response_id')
                        ->toArray();
                }

            }else{
                if (empty($response_ids)){
                    $response_ids = FormResponseField::where('form_field_id', $data_filter_1->form__fields_id)
                        ->where('response_value', $data_filter_1->compare_operator, $data_filter_1->compare_value)
                        ->pluck('form_response_id')
                        ->toArray();
                }
            }

        }

        $filtered_response_result_1 = DB::table('form_response_fields')
            ->join('form__fields', 'form__fields.id', '=', 'form_response_fields.form_field_id')
            ->whereIn('form_field_id', json_decode($report_data_representation->form_field_id));

        if($date_filter_1 or $data_filter_1){
            $filtered_response_result_1 = $filtered_response_result_1->whereIn('form_response_id', $response_ids);
        }

       //return $filtered_response_result_1;
           $filtered_response_result_1 = $filtered_response_result_1->select(DB::raw('count(form_response_fields.response_value) as count,
            sum(form_response_fields.response_value) as sum, max(form_response_fields.response_value) as max,
              min(form_response_fields.response_value) as min, avg(form_response_fields.response_value) as avg, form__fields.field_label '))
            ->groupBy('form__fields.field_label')
            ->get();

       global $dateCheck;
        //********************* Query for compare report type ****************************
        if($report->type === 'COMPARE'){
            $data['report_type'] = 'COMPARE';
            $date_filter_2 = reportDateFilter::with('formsFields')->where('report_id', $reportId)->where('filter_type', 2)->first();
            $data_filter_2 = reportDataFilter::where('report_id', $reportId)->where('filter_type', 2)->first();
            $response_ids = [];

            $data['date_2'] = $date_filter_2;

            if(!empty($date_filter_2->report_id)){
                $dateCheck = $date_filter_2->report_id;
            }

            if($date_filter_2){

                if ($date_filter_2->form__fields_id == $formId && $date_filter_2->form_id == $formId){
                    $response_ids = FormResponse::where('form_id', $formId)
                        ->whereBetween('response_date', [$date_filter_2->start_date, $date_filter_2->end_date])
                        ->pluck('id')
                        ->toArray();

                }else{
                    $response_ids = FormResponseField::where('form_id', $formId)
                        ->whereBetween('response_value', [$date_filter_2->start_date, $date_filter_2->end_date])
                        ->where('form_field_id', $date_filter_2->form__fields_id)
                        ->pluck('form_response_id')
                        ->toArray();
                }

            }


            if($data_filter_2){

                if ($date_filter_2 != null){

                    if (empty($response_ids)){
                        if ($date_filter_2->form__fields_id == $formId && $date_filter_2->form_id == $formId){
                            $response_ids = [];
                        }else{
                            $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                                ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                                ->where('form_field_id', $date_filter_2->form__fields_id)
                                ->whereBetween('response_value', [$date_filter_2->start_date, $date_filter_2->end_date])
                                ->pluck('form_response_id')
                                ->toArray();
                        }

                    }else{
                        $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                            ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                            ->whereIn('form_response_id', $response_ids)
                            ->pluck('form_response_id')
                            ->toArray();
                    }

                }else{
                    if (empty($response_ids)){
                        $response_ids = FormResponseField::where('form_field_id', $data_filter_2->form__fields_id)
                            ->where('response_value', $data_filter_2->compare_operator, $data_filter_2->compare_value)
                            ->pluck('form_response_id')
                            ->toArray();
                    }
                }

            }


            $filtered_response_result_2 = DB::table('form_response_fields')
                ->join('form__fields', 'form__fields.id', '=', 'form_response_fields.form_field_id')
                ->whereIn('form_field_id', json_decode($report_data_representation->form_field_id));

            if($date_filter_2 or $data_filter_2){
                $filtered_response_result_2 = $filtered_response_result_2->whereIn('form_response_id', $response_ids);
            }

            $filtered_response_result_2 = $filtered_response_result_2->select(DB::raw('count(form_response_fields.response_value) as count,
            sum(form_response_fields.response_value) as sum, max(form_response_fields.response_value) as max,
              min(form_response_fields.response_value) as min, avg(form_response_fields.response_value) as avg,  form__fields.field_label '))
                ->groupBy('form__fields.field_label')
                ->get();

        }

        global $dateCheck1;

        $fields =  Form_Fields::whereIn('id', json_decode($report_data_representation->form_field_id))
        ->select(DB::raw('0 as count,0 as sum, 0 as max, 0 as min, 0 as avg,  form__fields.field_label '))
        ->groupBy('form__fields.field_label')
        ->get();

        //query parameter get when request get to view
        if( $request->has('view') ) {
            $data['view'] = true;
        }

        if (!empty($date_filter_1->report_id)) {
            $dateCheck1 =  $date_filter_1->report_id;
        }
        $filtered_response_result_two=[];
        if(!empty($filtered_response_result_2)){
            $filtered_response_result_two =  $filtered_response_result_2;
        }
        //***************** Finally return data to view *********************
        $data['date_1'] = $date_filter_1;


        $data['date_filter2_report_id_1'] = $dateCheck1;
        $data['date_filter2_report_id'] = $dateCheck;

        $data['report'] = $report;
        $data['representation'] = $report_data_representation;
        $data['form_one'] = count($filtered_response_result_1) >0 ? $filtered_response_result_1:$fields;
        $data['form_two'] = count($filtered_response_result_two) >0 ? $filtered_response_result_two:$fields;

        $total_form_one = 0;
        $total_form_two = 0;

        foreach ($data['form_one'] as $form_one){
            $total_form_one = $total_form_one + $form_one->count;
        }

        foreach ($data['form_two'] as $form_two){
            $total_form_two = $total_form_two + $form_two->count;
        }

        $data['total_records_form_one'] = $total_form_one;
        $data['total_records_form_two'] = $total_form_two;

        // For Email ,,, type,department,category value filter
        $departments_ids = $report->departments->pluck('id');
        $category_ids = $report->categories->pluck('id');
        $type_ids = $report->types->pluck('id');

        if ($departments_ids == null){
            $departments_ids = [];
        }
        if ($category_ids == null){
            $category_ids = [];
        }
        if ($type_ids == null){
            $type_ids = [];
        }

        // select user department,type,category wise
        $emails = Staff::whereHas('departments', function (Builder $query) use ($departments_ids) {
            $query->whereIn('department_id',$departments_ids);
        })->orWhereHas('categories', function (Builder $query) use ($category_ids) {
            $query->whereIn('category_id',$category_ids);
        })->orWhereHas('types', function (Builder $query) use ($type_ids) {
            $query->whereIn('type_id',$type_ids);
        })->pluck('email');

        $data['pdf'] = PDF::loadView('emails.reportPreview', [
            'data'=>$data,
            'format' => 'A4'
        ]);

        Mail::to($emails)->send(new ReportPreview($data));
        return redirect()->back()->with('message', 'Mail Send Successfully.');
//        return view('emails.reportPreview', ['data'=>$data]);

    }


    // Report Automation
    public function create_automation(Request $request){

        $data['user_type'] = Auth::user()->user_type;
        if ($data['user_type'] =='admin'){
            $data['organizations'] = Organization::get();
        }else{
            $data['organization_id'] = $request->organization_id;
        }
        return Inertia::render('Report/automation', ['data'=>$data]);
    }

    public function generateReportAutomation(Request $request){

        $get_report = Report::where('id', $request->report_id)->first();
        $departments_ids = $get_report->departments->pluck('id');
        $category_ids = $get_report->categories->pluck('id');
        $type_ids = $get_report->types->pluck('id');

        $code = mt_rand(100, 999);
        $name = $get_report->report_name;
        $reportName = $name .' '.'#'.$code;

        $last_running_time = $request->last_running_time;
        $slug = sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));

        $report_params = [
            'report_name' => $reportName,
            'description' => $get_report->description,
            'form_id' => $get_report->form_id,
            'category_id' =>$get_report->category_id,
            'organization_id' => $get_report->organization_id,
            'created_by' =>   Auth::user()->id,
            'slug' => $slug,
            'type' => $get_report->type,
            'is_for_automation' => $request->is_for_automation,
            'interval' => $request->interval,
//            'duration' => $request->duration,
            'last_running_time' => $last_running_time,
        ];

        $reports = Report::create($report_params);
        $reports->departments()->sync($departments_ids);
        $reports->categories()->sync($category_ids);
        $reports->types()->sync($type_ids);

        // report Data
        $reportData = ReportDataRepresentation::where('report_id', $request->report_id)->first();
        if ($reportData != null){
            $reportData_params = [
                'report_id' => $reports->id,
                'form_id' => $reportData->form_id,
                'form_field_id' => $reportData->form_field_id,
                'total' => $reportData->total,
                'lowest' => $reportData->lowest,
                'highest' => $reportData->highest,
                'average' => $reportData->average,
                'created_by' => $reportData->created_by
            ];
            $get_report_data = ReportDataRepresentation::create($reportData_params);
        }

        //Date Filter
        $reportDates = reportDateFilter::where('report_id', $request->report_id)->get();
        if ($reportDates != null){
            foreach ($reportDates as  $reportDate){
                //dd('yes');
                $reportDate_params = [
                    'report_id' => $reports->id,
                    'form_id' => $reportDate->form_id,
                    'form__fields_id' => $reportDate->form__fields_id,
                    'start_date' => $reportDate->start_date,
                    'end_date' => $reportDate->end_date,
                    'filter_type' => $reportDate->filter_type,
                    'created_by' => $reportDate->created_by
                ];
                $get_reportDate = reportDateFilter::create($reportDate_params);
            }
        }

        //Data Filter
        $reportDatas = reportDataFilter::where('report_id', $request->report_id)->get();
        if ($reportDatas != null){
            foreach ($reportDatas as  $reportData){
                $reportData_params = [
                    'report_id' => $reports->id,
                    'form_id' => $reportData->form_id,
                    'form__fields_id' => $reportData->form__fields_id,
                    'compare_operator' => $reportData->compare_operator,
                    'compare_value' => $reportData->compare_value,
                    'filter_type' => $reportData->filter_type,
                    'created_by' => $reportData->created_by
                ];
                $get_reportData = reportDataFilter::create($reportData_params);
            }
        }
        return redirect()->route('reports.edit',['slug' => $reports->slug]);

    }

    public function getReport($id)
    {
        $reports = Report::where([
            'organization_id' => $id,
            'is_for_automation' => 'NO',
        ])->get();
        $data['reports'] = $reports;

        return response()->json($data, Response::HTTP_OK);
    }
    public function getReportSlug($id)
    {
        $reports = Report::where('id', $id)->pluck('slug');
        $data['slug'] = $reports;

        return response()->json($data, Response::HTTP_OK);
    }

    //Report Automation Show
    public function reportAutomationShow($slug){
        $data = Report::where('slug', $slug)->with( 'departments', 'categories', 'types')->first();
        $data['edit'] = 'yes';

        $data['next_report_generate_date'] =  Carbon::parse($data->last_running_time)->addHours($data->interval);
        $data['next_report_generate_date'] =  Carbon::parse($data['next_report_generate_date'])->format('Y-m-d H:i:s');
        $data['date_range'] = reportDateFilter::where('report_id', $data->id)->get();

        $next_date_range = [];

        if ( $data['date_range'] != null){
            foreach ( $data['date_range'] as  $reportDate){
                //Add Duration
                $datetime2 = strtotime($reportDate->end_date); // convert to timestamps
                $datetime1 = strtotime($reportDate->start_date); // convert to timestamps
                $days = (int)(($datetime2 - $datetime1)/86400);

                $new_end_date = Carbon::parse($reportDate->end_date)->addDays($days);
                $new_end_date = Carbon::parse($new_end_date)->format('Y-m-d');
                $new_end_date = $new_end_date.'T00:00:00.000Z';


                $reportDate_params = [
                    'report_id' => $data->id,
                    'form_id' => $reportDate->form_id,
                    'form__fields_id' => $reportDate->form__fields_id,
                    'start_date' => $reportDate->end_date,
                    'end_date' => $new_end_date,
                    'filter_type' => $reportDate->filter_type,
                ];

                 array_push($next_date_range, $reportDate_params );
            }

        }
        $data['next_date_range'] = $next_date_range;

        $data['histories'] = ReportAutomationHistory::with('report','reportAutomation')
            ->where('report_automation_id', $data->id)->latest()
            ->paginate(10);
//dd($data['histories']);
        $category_id = $data->category_id;
        $data['all_forms'] = Form::whereHas('categories', function($q) use ($category_id){
            $q->where('category_id', $category_id);
        })->get();

        $data['user_type'] = Auth::user()->user_type;
        if ($data['user_type'] =='admin'){

            $data['organizations'] = Organization::get();
            $data['all_departments'] = Department::all();
            $data['all_categories'] = Category::all();
            $data['all_types'] = Type::all();
        }else{
            $data['organization_id'] = Auth::user()->organization_id;
            $data['all_departments'] = Department::where('organization_id', $data['organization_id'])->get();
            $data['all_categories'] = Category::where('organization_id', $data['organization_id'])->get();
            $data['all_types'] = Type::where('organization_id', $data['organization_id'])->get();
        }

        return Inertia::render('Report/auto_view', ['data'=>$data]);

    }

    //Report Automation Schedule
    public function reportAutomationSchedule(){

        $current_time = Carbon::now();

        $get_reports = Report::where('is_for_automation','YES')->get();
//        ->where('id',248)
        foreach ($get_reports as $get_report){
            //Add interval
            $running_time_with_interval =  Carbon::parse($get_report->last_running_time)->addHours($get_report->interval);
            $running_time_with_interval->subHours(6);
//            dd($running_time_with_interval->toDateTimeString());
            $history_last_running_time = $get_report->last_running_time;

            if ($running_time_with_interval->toDayDateTimeString() == $current_time->toDayDateTimeString()){

                // Current Report Update
                $get_report->update([
                    'last_running_time' => $running_time_with_interval->addHours(6),
                ]);

                $departments_ids = $get_report->departments->pluck('id');
                $category_ids = $get_report->categories->pluck('id');
                $type_ids = $get_report->types->pluck('id');

                $code = mt_rand(100, 999);
                $name = $get_report->report_name;
                $reportName = $name .' '.'#'. $code;

                $slug = sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));

                $report_params = [
                    'report_name' => $reportName,
                    'description' => $get_report->description,
                    'form_id' => $get_report->form_id,
                    'category_id' =>$get_report->category_id,
                    'organization_id' => $get_report->organization_id,
                    'created_by' =>  $get_report->created_by,
                    'slug' => $slug,
                    'type' => $get_report->type,
                    'is_for_automation' => 'NO',
                    'interval' => $get_report->interval,
                    'duration' => $get_report->duration,
                    'last_running_time' => $running_time_with_interval,
                ];

                $reports = Report::create($report_params);
                $reports->departments()->sync($departments_ids);
                $reports->categories()->sync($category_ids);
                $reports->types()->sync($type_ids);

                // report Data
                $reportData = ReportDataRepresentation::where('report_id', $get_report->id)->first();
                if ($reportData != null){
                    $reportData_params = [
                        'report_id' => $reports->id,
                        'form_id' => $reportData->form_id,
                        'form_field_id' => $reportData->form_field_id,
                        'total' => $reportData->total,
                        'lowest' => $reportData->lowest,
                        'highest' => $reportData->highest,
                        'average' => $reportData->average,
                        'created_by' => $reportData->created_by
                    ];
                    $get_report_data = ReportDataRepresentation::create($reportData_params);
                }

                //Date Filter
                $reportDates = reportDateFilter::where('report_id', $get_report->id)->get();
                if ($reportDates != null){
                    foreach ($reportDates as  $reportDate){
                        //Add Duration
                        $datetime2 = strtotime($reportDate->end_date); // convert to timestamps
                        $datetime1 = strtotime($reportDate->start_date); // convert to timestamps
                        $days = (int)(($datetime2 - $datetime1)/86400);

                        $new_end_date = Carbon::parse($reportDate->end_date)->addDays($days);
                        $new_end_date = Carbon::parse($new_end_date)->format('Y-m-d');
                        $new_end_date = $new_end_date.'T00:00:00.000Z';

//                        previous report date update
                        $reportDate->update([
                            'start_date' => $reportDate->end_date,
                            'end_date' => $new_end_date,
                        ]);

                        $reportDate_params = [
                            'report_id' => $reports->id,
                            'form_id' => $reportDate->form_id,
                            'form__fields_id' => $reportDate->form__fields_id,
                            'start_date' => $reportDate->end_date,
                            'end_date' => $new_end_date,
                            'filter_type' => $reportDate->filter_type,
                            'created_by' => $reportDate->created_by
                        ];
                        $get_reportDate = reportDateFilter::create($reportDate_params);
                    }
                }

                //Data Filter
                $reportDatas = reportDataFilter::where('report_id', $get_report->id)->get();
                if ($reportDatas != null){
                    foreach ($reportDatas as  $reportData){
                        $reportData_params = [
                            'report_id' => $reports->id,
                            'form_id' => $reportData->form_id,
                            'form__fields_id' => $reportData->form__fields_id,
                            'compare_operator' => $reportData->compare_operator,
                            'compare_value' => $reportData->compare_value,
                            'filter_type' => $reportData->filter_type,
                            'created_by' => $reportData->created_by
                        ];
                        $get_reportData = reportDataFilter::create($reportData_params);
                    }
                }

                //Report Automation History
                ReportAutomationHistory::create([
                    'report_id' => $reports->id,
                    'report_automation_id' => $get_report->id,
                    'previous_running_time' => $history_last_running_time,
                    'last_running_time' => $running_time_with_interval
                ]);
            }

        }
        return "true";
    }

    //Report Automation History Delete
    public function ReportAutomationHistoryDelete($id){
        ReportAutomationHistory::find($id)->delete();
        return redirect()->back()->with('message', 'History Deleted Successfully.');

    }
}


