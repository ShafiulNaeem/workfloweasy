<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Role;
use App\Models\Permission;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class RoleController extends Controller
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
                $data = Role::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->latest()
                    ->get();
                //dd($results);
            }else{
                $data = Role::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->latest()
                    ->get();
            }

        }else{
            $data = Role::where($where)->latest()->get();
        }

        foreach ($data as $key=>$value) {
          $ex = explode(",",$value->permissions);

            $data[$key]['permissions'] = Permission::wherein('id', $ex)->pluck('name');


        }
        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('role/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $query)
    {
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['roles.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
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
      $data['permission'] = Permission::all();
      return Inertia::render('role/create', ['data' => $data]);
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
      $ar = $request->permissions;

      $data = $request->all();
      $data['created_by'] = Auth::user()->id;
      Role::create($data);

      return Redirect::route('roles.index')->with('message', 'Role Created Successfully.');
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
      $data = Role::find($id);
      $data['title'] = 'Update Role';

      return Inertia::render('role/edit', ['data' => $data]);
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
          Role::find($id)->update($data);
//          return redirect()->back()
//              ->with('message', 'Role Updated Successfully.');


//        NB: redirect()->back() in not working
        return Redirect::route('roles.index')->with('message', 'Role Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
      Role::find($id)->delete();
      return redirect()->back();
    }
}
