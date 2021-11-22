<?php

namespace App\Http\Controllers;

use App\Models\Form;
use App\Models\FormResponse;
use App\Models\Task;
use App\Models\Type;
use Illuminate\Http\Request;
use App\Models\Department;
use App\Models\Organization;
use App\Models\Staff;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class DashboardController extends Controller
{
    public function dashboard(Request $request){

        $type = Auth::user()->name;

        $where = array();
        $where = $this->getQuery($where, $request);

        $forms = Form::where($where)->with('departments', 'categories', 'types');

        $forms = $this->filter($forms, $request);

        $form_ids = $forms->pluck('id');

        $assingment = FormResponse::whereIn('form_id', $form_ids)
            ->with('form.categories')->paginate(10);

        $data['type'] = $type;
        $data['data'] = $assingment;

        return Inertia::render('Home',['data' => $data]);
    }


    // form filtering by staff access
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
        if (!empty($request->organization_id)) {
            $where = array_merge(array(['forms.organization_id', $request->organization_id]), $where);
        }

        return $where;
    }


}
