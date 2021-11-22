<?php

namespace App\Http\Controllers;

use App\Models\Form;
use App\Models\FormAutomation;
use App\Models\Report;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use App\Models\Category;
use App\Models\Organization;
use App\Models\Staff;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Auth;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $data = [];
        $query = $request->query();
        //dd($query);
        $where = array();
        $where = $this->getQuery($where, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            if (!empty($where)){
                $data = Category::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }else{

                $data = Category::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($request->except('organization_id','access'));
            }

        }else{
            $data = Category::where($where)
                ->with('organization')
                ->latest()
                ->paginate(10)
                ->appends($request->except('organization_id','access'));
        }

        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('Category/index', ['data' => $param]);
    }

    // search query builder
    public function getQuery($where, $request)
    {
        $query = $request->query();
        //dd($query);
        if (!empty($query['search_type']) && !empty($query['search_text'])) {

            if ($query['search_type'] == 'name') {
                $where = array_merge(array(['categories.name', 'LIKE', '%' . $query['search_text'] . '%']), $where);
            }

        }

        if (!empty($request->organization_id)) {
            $where = array_merge(array(['categories.organization_id', $request->organization_id]), $where);
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
        $data['organizations'] = Organization::all();
        return Inertia::render('Category/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
//        dd($request->all());
        Validator::make($request->all(), [
            'name' => ['required'],
            'organization_id' => ['required'],
        ])->validate();

        $data = $request->all();
        $data['created_by'] = Auth::user()->id;
        if (Auth::user()->user_type == 'admin') {
            Category::create($data);
        } else {
//            $staff = Staff::where('user_id', Auth::user()->id)->first();
            $data['organization_id'] = $request->organization_id;
            Category::create($data);

        }
        if ($request->index == null){
            return redirect()->back()->with('message', 'Category Created Successfully.');
        }else{
            return Redirect::route('categories.index')->with('message', 'Category Created Successfully.');
        }


    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = Category::find($id);
        $data['title'] = 'View Category';
        $data['organizations'] = Organization::all();

        return Inertia::render('Category/view', ['data' => $data]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = Category::find($id);
        $data['title'] = 'Edit Category';
        $data['organizations'] = Organization::all();

        return Inertia::render('Category/edit', ['data' => $data]);
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
        $data['updated_by'] = Auth::user()->id;
        Category::find($id)->update($data);
        return Redirect::route('categories.show',$id)->with('message', 'Category Updated Successfully.');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $staff = Staff::WhereHas('categories', function (Builder $query) use ($id) {
            $query->where('category_id',$id);
        })->count();

        $form = Form::WhereHas('categories', function (Builder $query) use ($id) {
            $query->where('category_id',$id);
        })->count();

        $report = Report::WhereHas('categories', function (Builder $query) use ($id) {
            $query->where('category_id',$id);
        })->count();

        $formAutomation = FormAutomation::WhereHas('categories', function (Builder $query) use ($id) {
            $query->where('category_id',$id);
        })->count();

        if ($staff > 0 or $form > 0 or $report > 0 or $formAutomation > 0) {
            return redirect()->back()->with('message', 'You Can Not Delete This Category');
        } else {
            Category::find($id)->delete();
            return redirect()->back()->with('message', 'Category Deleted Successfully.');
        }
    }
}
