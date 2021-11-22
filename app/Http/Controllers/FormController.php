<?php

namespace App\Http\Controllers;

use App\Models\FormAutomation;
use App\Models\FormDepartment;
use App\Models\FormResponse;
use App\Models\FormResponseField;
use App\Models\FormSetting;
use App\Models\Task;
use App\Models\Type;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Form;
use App\Models\Form_Fields;
use App\Models\FormFieldOption;
use App\Models\Organization;
use App\Models\Category;
use App\Models\Department;
use App\Models\Staff;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Response;
use Auth;

class FormController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $query = $request->all();
        $where = array();
        $where = $this->getQuery($where, $request);

        $data = Form::where($where)->with('organization','departments', 'categories', 'types')->latest();
        $data = $this->search($data, $request);


        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }
        $data = $data->paginate(10)->appends($request->except('organization_id','access'));

        $param['query'] = $request->except('organization_id','access');
        $param['data'] = $data;

        // Create task
        $param['user_type'] = Auth::user()->user_type;
        if (Auth::user()->user_type == 'admin') {
            $param['organizations'] = Organization::all();
        } else {
            $param['organization_id'] = Auth::user()->organization_id;
        }

        return Inertia::render('form/index', ['data' => $param]);

    }

    // form filtering by staff access
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

    public function filter($data, $request)
    {
        if($request->access){
            $data = $data->whereHas('departments', function($q) use($request){
                $q->whereIn('departments.id', $request->access['department_ids']);
            })->orWhereHas('categories', function($q) use($request){
                $q->whereIn('categories.id', $request->access['category_ids']);
            })->orWhereHas('types', function($q) use($request){
                $q->whereIn('types.id', $request->access['type_ids']);
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
                $where = array_merge(array(['forms.Form_title', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }

            if ($query['search_type'] == 'id') {
                $where = array_merge(array(['forms.id', $query['search_text']]), $where);
            }

        }

        if (!empty($request->organization_id)) {
            $where = array_merge(array(['forms.organization_id', $request->organization_id]), $where);
        }
        return $where;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function form_data(Request $request)
    {
        $param = [];
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $request);

        $data = Form::where($where)->with('organization', 'form_responses','categories','departments','types')->latest();

        $data = $this->search($data, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            $data = $data->whereBetween('created_at', [$request->from_date, $request->to_date]);
        }

        $data = $data->paginate(10)->appends($query);

//        if (!empty(Auth::user()->organization_id)){
//            $param['categories'] = Category::where('organization_id',Auth::user()->organization_id)->get();
//        }else{
//            $param['categories'] = Category::all();
//        }

        $param['query'] = $query;
        $param['data'] = $data;

        return Inertia::render('form/form_data', ['data' => $param]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function precreate(Request $request)
    {
        $data['code'] = mt_rand(10000000, 99999999);
        $data['categories'] = Category::all();
        $data['user_type'] = Auth::user()->user_type;

        if ($data['user_type'] == 'admin') {
            $data['categories'] = Category::get();
            $data['organizations'] = Organization::get();
        }  else {
            $data['organization_id'] = $request->organization_id;
            $data['categories'] = Category::where('organization_id', $request->organization_id)->get();
            $data['departments'] = FormDepartment::where('organization_id', $request->organization_id)->get();
        }
        return Inertia::render('form/pre', ['data' => $data]);
    }

    // form create step one
    public function generate(Request $request)
    {

        //dd($request->all());
        $data['code'] = mt_rand(1000000, 9999999);
        //$data['categories'] = Category::all();
        $data['user_type'] = Auth::user()->user_type;
        $data['step'] = 'one';
        $data['organization_id'] =  $request->organization_id;
        $data['organizations'] = Organization::get();
        $data['all_departments'] = Department::where('organization_id', $request->organization_id)->get();
        $data['all_categories'] = Category::where('organization_id', $request->organization_id)->get();
        $data['all_types'] = Type::where('organization_id', $request->organization_id)->get();

        return Inertia::render('form/create_form', ['data' => $data]);
    }

    public function categories($id)
    {
        $data = Category::where('organization_id', $id)->get();

        return response()->json($data, Response::HTTP_OK);
    }

    public function departments($id)
    {
        $data = FormDepartment::where('organization_id', $id)->get();

        return response()->json($data, Response::HTTP_OK);
    }

    public function create(Request $request)
    {
        //dd( $request->all());
        Validator::make($request->all(), [
            'Form_title' => ['required'],
           // 'description' => ['required'],
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();


        $data = $request->all();
        $data['slug'] = sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
        $data['created_by'] = Auth::user()->id;

        $form = Form::create($data);
        // create many to many table data
        $form->departments()->sync($request->department_ids);
        $form->categories()->sync($request->category_ids);
        $form->types()->sync($request->type_ids);
        return redirect()->route('add_fields', ['slug' => $form->slug]);
    }

    public function add_fields(Request $request){
        $data['step'] = 'two';
        $form =  Form::where('slug', $request->slug)->first();
        $data['form_slug'] = $request->slug;
        $data['form'] = $form;
        $data['fields'] = Form_Fields::where('form_id', $form->id)->with('options')->orderBy('field_order', 'asc')->get();

        return Inertia::render('form/create_form', ['data' => $data]);
    }

    public function form_settings(Request $request){
        $data['step'] = 'three';
        $form =  Form::where('slug', $request->slug)->first();
        $setting =  FormSetting::where('form_id', $form->id)->first();
        $data['form_slug'] = $request->slug;
        $data['form'] = $form;
        $data['setting'] = $setting;

        if (Auth::user()->user_type == 'admin'){
            $data['automations'] = FormAutomation::all();
        }else{
            $data['automations'] = FormAutomation::where('organization_id',Auth::user()->organization_id)->get();
        }

        return Inertia::render('form/create_form', ['data' => $data]);
    }

    // update form setting
    public function update_settings(Request $request){
        $form =  Form::where('id', $request->form_id)->first();
        $data = $request->only('is_public', 'is_password_protected', 'password','form_automation_id');
        $data['form_id'] = $form->id;
        $data['form_automation_id'] = $request->form_automation_id;
        $settings = FormSetting::where('form_id', $request->form_id)->first();
        if($settings){
            $settings->update($data);
        }else{
            FormSetting::create($data);
        }

        // handle return type
        if($request->type == 'next'){
            return redirect()->route('form_settings', ['slug' => $form->slug]);
        }elseif ($request->type == 'preview'){
            return redirect()->back();
        }else{
            return redirect()->route('forms.index');
        }
    }

    // update form setting
    public function update_form_info(Request $request){

        Validator::make($request->all(), [
            'Form_title' => ['required'],
            'organization_id' => ['required'],
            'department_ids' => ['required'],
            'category_ids' => ['required'],
            'type_ids' => ['required'],
        ])->validate();

        $form =  Form::where('id', $request->form_id)->first();
        $data = $request->only('organization_id', 'Form_title', 'description');

        $data['updated_by'] = Auth::user()->id;
        $form->update($data);
        // create many to many table data
        $form->departments()->sync($request->department_ids);
        $form->categories()->sync($request->category_ids);
        $form->types()->sync($request->type_ids);

        return redirect()->route('add_fields', ['slug' => $form->slug]);
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
            'Form_title' => ['required'],
        ])->validate();
        $data = $request->all();
        $random = rand(1111, 9999);
        $slu = strtolower(str_replace(' ', '-', $data['Form_title']));
        $slug = $random . '-' . $slu;
        $data['created_by'] = Auth::user()->id;

        if (Auth::user()->user_type == 'admin') {
            $us = Form::create([
                'Form_title' => $data['Form_title'],
                'category_id' => $data['category_id'],
                'from_department_id' => $data['from_department_id'],
                'description' => $data['description'],
                'organization_id' => $data['organization_id'],
                'slug' => $slug,
                'created_by' => auth::user()->id
            ]);
        } elseif (Auth::user()->user_type == 'owner') {
             $us = Form::create([
                'Form_title' => $data['Form_title'],
                'category_id' => $data['category_id'],
                'from_department_id' => $data['from_department_id'],
                'description' => $data['description'],
                'organization_id' => $request->organization_id,
                'slug' => $slug,
                 'created_by' => auth::user()->id
            ]);
        } else {
             $us = Form::create([
                'Form_title' => $data['Form_title'],
                'category_id' => $data['category_id'],
                'from_department_id' => $data['from_department_id'],
                'description' => $data['description'],
                'organization_id' => $request->organization_id,
                'slug' => $slug,
                 'created_by' => auth::user()->id
            ]);
        }
        $fields = $request->fields;

        foreach ($fields as $key => $field) {
            $field_name = strtolower(str_replace(' ', '_', $field['field_label']));
            $uss = Form_Fields::create([
                'form_id' => $us->id,
                'field_type' => $field['field_type'],
                'field_label' => $field['field_label'],
                'field_name' => $field_name,
                'field_instruction' => $field['field_instruction'],
                'field_placeholder' => $field['field_label'],
                'field_default_value' => $field['field_default_value'],
                'field_is_required' => $field['field_is_required'],
                'created_by' => auth::user()->id,
                'field_order' => $key,
            ]);
            if ($field['field_type'] == 'multiselect') {
                $options = $field['options'];
                foreach ($options as $option) {
                    $usss = FormFieldOption::create([
                        'form__fields_id' => $uss->id,
                        'option_title' => $option['option_title'],
                        'option_value' => $option['option_value'],
                        'created_by' => auth::user()->id
                    ]);
                }
            } elseif ($field['field_type'] == 'dropdown') {
                $options = $field['options'];
                foreach ($options as $option) {
                    $usss = FormFieldOption::create([
                        'form__fields_id' => $uss->id,
                        'option_title' => $option['option_title'],
                        'option_value' => $option['option_value'],
                        'created_by' => auth::user()->id
                    ]);
                }
            }
        }


        return Redirect::route('forms.index')->with('message', 'Form Created Successfully.');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }


    public function edit(Request $request, $id)
    {
        $data = Form::where('id', $id)->with('departments', 'categories', 'types')->first();

        $data['user_type'] = Auth::user()->user_type;
        $data['step'] = 'one';
        $data['mode'] = 'edit';

        $data['organizations'] = Organization::all();
        $data['organization_id'] = $data->organization_id;
        $data['all_categories'] = Category::where('organization_id', $data->organization_id)->get();
        $data['all_departments'] = Department::where('organization_id', $data->organization_id)->get();
        $data['all_types'] = Type::where('organization_id', $data->organization_id)->get();


        return Inertia::render('form/create_form', ['data' => $data]);
    }


    public function update(Request $request, $id)
    {

        Validator::make($request->all(), [
            'Form_title' => ['required'],
        ])->validate();
        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;
        $form = Form::find($id);
        $form->update($data);
        $fields = $data['fields'];

        foreach ($fields as $key => $field) {
            if (isset($field['id']) && !isset($field['deleted'])) {
                // Update_existing_fields...
                $uss = Form_Fields::where('id', $field['id'])->update([
                    'field_type' => $field['field_type'],
                    'field_label' => $field['field_label'],
                    'field_name' => $field['field_label'],
                    'field_placeholder' => $field['field_label'],
                    'field_default_value' => $field['field_default_value'],
                    'field_instruction' => $field['field_instruction'],
                    'field_is_required' => $field['field_is_required'],
                    'updated_by' => $data['updated_by'],
                    'field_order' => $key,
                ]);
                if ($field['field_type'] == 'multiselect' or $field['field_type'] == 'dropdown') {
                    $options = $field['options'];

                    foreach ($options as $option) {
                        if (isset($option['id']) && !isset($option['deleted'])) {
                            $usss = FormFieldOption::where('id', $option['id'])->update([
                                'option_title' => $option['option_title'],
                                'option_value' => $option['option_value'],
                                'updated_by' => $data['updated_by'],
                            ]);
                        } elseif (isset($option['deleted']) == '1') {
                            $del = FormFieldOption::find($option['id'])->delete();
                        } else {
                            $usss = FormFieldOption::create([
                                'form__fields_id' => $field['id'],
                                'option_title' => $option['option_title'],
                                'option_value' => $option['option_value'],
                                'updated_by' => $data['updated_by'],
                            ]);
                        }

                    }
                }
            } elseif (isset($field['deleted'])) {
                $del = Form_Fields::find($field['id'])->delete();
            } else {

                $get_form_fields = Form_Fields::where([
                    'form_id' => $data['id'],
                    'field_label' =>  $field['field_label']
                ])->count();

                if ($get_form_fields == 0){

                    $uss = Form_Fields::create([
                        'form_id' => $data['id'],
                        'field_type' => $field['field_type'],
                        'field_label' => $field['field_label'],
                        'field_name' => $field['field_label'],
                        'field_placeholder' => $field['field_label'],
                        'field_default_value' => $field['field_default_value'],
                        'field_instruction' => $field['field_instruction'],
                        'field_is_required' => $field['field_is_required'],
                        'updated_by' => $data['updated_by'],
                        'field_order' => $key,
                    ]);
                    if ($field['field_type'] == 'multiselect' or $field['field_type'] == 'dropdown') {
                        $options = $field['options'];
                        foreach ($options as $option) {
                            $option_title = isset($option['option_title'])?$option['option_title']:null;
                            $option_value = isset($option['option_value'])?$option['option_value']:null;
                            $usss = FormFieldOption::create([
                                'form__fields_id' => $uss->id,
                                'option_title' =>$option_title,
                                'option_value' => $option_value,
                                'updated_by' => $data['updated_by'],
                            ]);
                        }
                    }
                }

            }

        }

        // handle return type
        if($request->type == 'next'){
            return redirect()->route('form_settings', ['slug' => $form->slug]);
        }elseif ($request->type == 'preview'){
            return redirect()->back();

        }else{
            return redirect()->route('forms.index');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */

    public function destroy($id)
    {
//        $check = Task::where('form_id', $id)->first();
        $check2 = FormResponse::where('form_id', $id)->first();

        if ($check2) {
            return redirect()->back()->with('message', 'You Can Not Delete This Form');
        } else {
            Form::find($id)->delete();
            return redirect()->back()->with('message', 'Deleted Successfully.');
        }
    }

    public function removeField($id)
    {
        Form_Fields::find($id)->delete();
        FormFieldOption::where('form__fields_id', $id)->delete();
        FormResponseField::where('form_field_id', $id)->delete();
        return "ok";

    }

//removeFieldOption
    public function removeFieldOption($id)
    {
        FormFieldOption::where('id', $id)->delete();
        return "ok";

    }
}
