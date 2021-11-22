<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Permission;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class PermissionController extends Controller
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
      $where = $this->getQuery($where, $query);

        $data = Permission::where($where)->latest()->get();
        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('permission/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $query)
    {
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['permissions.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
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
      $data['code'] = mt_rand(10000000, 99999999);
      return Inertia::render('permission/create', ['data' => $data]);
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
      ])->validate();

      $data = $request->all();
      $data['created_by'] = Auth::user()->id;
      Permission::create($data);

      return Redirect::route('permissions.index')->with('message', 'Permission Created Successfully.');
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
    public function edit($id)
    {
      $data = Permission::find($id);
      $data['title'] = 'Update Permission';

      return Inertia::render('permission/edit', ['data' => $data]);
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
      ])->validate();

      $data = $request->all();
      $data['updated_by'] = Auth::user()->id;
          Permission::find($id)->update($data);
          return redirect()->back()
              ->with('message', 'Permission Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
      Permission::find($id)->delete();
      return redirect()->back();
    }
}
