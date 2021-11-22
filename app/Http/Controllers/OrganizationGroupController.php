<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Form;
use App\Models\Organization;
use App\Models\OrganizationGroup;
use App\Models\Staff;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class OrganizationGroupController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $data = OrganizationGroup::all();
        $param['data'] = $data;
        return Inertia::render('OrganizationGroup/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $query)
    {
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['categories.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }

        }

        if (!empty($query['organization_id'])) {
            $where = array_merge(array(['categories.organization_id', $query['organization_id']]), $where);
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
//        $data['code'] = mt_rand(10000000, 99999999);
        $data['organizations'] = OrganizationGroup::all();
        return Inertia::render('OrganizationGroup/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $data = $request->all();
        $data['is_default'] = $data['is_default']?1:0;
        OrganizationGroup::create($data);
        return Redirect::route('organization-group.index')->with('message', 'Category Created Successfully.');

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
        $data = OrganizationGroup::find($id);
        $data['title'] = 'Edit Category';

        return Inertia::render('OrganizationGroup/edit', ['data' => $data]);
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
        $data['is_default'] = $data['is_default']?1:0;
        OrganizationGroup::find($id)->update($data);
        return redirect()->back()
            ->with('message', 'Organiztion Group Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
            OrganizationGroup::find($id)->delete();
            return redirect()->back();
    }
}
