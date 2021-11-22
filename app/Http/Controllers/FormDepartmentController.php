<?php

namespace App\Http\Controllers;

use App\Models\FormDepartment;
use App\Models\Organization;
use App\Models\OrganizationGroup;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class FormDepartmentController extends Controller
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
        $where = $this->getQuery($where, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            if (!empty($where)){
                $data = FormDepartment::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
                //dd($results);
            }else{
                $data = FormDepartment::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }

        }else{
            $data = FormDepartment::where($where)
                ->with('organization')
                ->latest()
                ->paginate(10)
                ->appends($request->except('organization_id','access'));
        }

        //$data = FormDepartment::where($where)->with('organization')->latest()->get();

        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('form_department/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $query)
    {
        if (!empty($query['search_type']) && !empty($query['search_text'])) {
            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['form_departments.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }
            // if ($query['search_type'] == 'organization') {
            //     $orgId = Organization::where('name', $query['search_text'])->first();
            //     $where = array_merge(array(['form_departments.organization_id', $orgId->id]), $where);
            // }
        }

         if (!empty($query['organization_id'])) {
             $where = array_merge(array(['form_departments.organization_id', $query['organization_id']]), $where);
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
        $data['organizations'] = Organization::all();
        return Inertia::render('form_department/create', ['data' => $data]);
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
//            'organization_id' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['created_by'] = Auth::user()->id;

        FormDepartment::create($data);
        return Redirect::route('form-department.index')->with('message', 'Form Department Created Successfully.');

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

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = FormDepartment::find($id);
        $data['title'] = 'Edit Form Department';

        return Inertia::render('form_department/edit', ['data' => $data]);
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
        ])->validate();

        $data = $request->all();
        FormDepartment::find($id)->update($data);
        return redirect()->back()
            ->with('message', 'Form Department  Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        FormDepartment::find($id)->delete();
        return redirect()->back();
    }
}
