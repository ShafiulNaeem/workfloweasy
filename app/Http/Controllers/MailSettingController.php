<?php

namespace App\Http\Controllers;

use App\Models\MailSetting;
use Illuminate\Http\Request;
use App\Models\Type;
use App\Models\Organization;
use App\Models\Staff;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;

class MailSettingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        // dd($request->all());
        $data = [];
        $query = $request->query();
        $where = array();
        $where = $this->getQuery($where, $request);

        if (!empty($request->from_date) && !empty($request->to_date)){
            if (!empty($where)){
                $data = MailSetting::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->where($where)
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($query);
            }else{

                $data = MailSetting::whereBetween('created_at', [$request->from_date, $request->to_date])
                    ->with('organization')
                    ->latest()
                    ->paginate(10)
                    ->appends($query);
            }

        }else{
            $data = MailSetting::where($where)
                ->with('organization')
                ->latest()
                ->paginate(10)
                ->appends($query);
        }

        $param['query'] = $query;
        $param['data'] = $data;
        return Inertia::render('mailSettings/index',  ['data' => $param]);
    }
      // search query builder
      public function getQuery($where, $request)
      {
          if (!empty($query['search_type']) && !empty($query['search_text'])) {

              if ($query['search_type'] == 'name') {
                  $where = array_merge(array(['mail_settings.protocol', 'LIKE', '%' . $query['search_text'] . '%']), $where);
              }

          }

        //   if (!empty($request->organization_id)) {
        //      return $where = array_merge(array(['mail_settings.organization_id', $request->organization_id]), $where);
        //   }

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
        $data['user_type'] =  Auth::user()->user_type;
      
        return Inertia::render('mailSettings/create', ['data' => $data]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       //   dd($request->all());
          Validator::make($request->all(), [
            'protocol' => ['required'],
            'type' => ['required'],
            'host' => 'required',
            'port' => 'required|min:4|regex:/[0-9]/',
            'email' => ['required'],
            'password' => ['required'],
        ])->validate();

        $data = $request->all();

        $getOrg =  MailSetting::where('organization_id', $request->input('organization_id'))->first();
            if($getOrg == null){
                $data['password'] = Hash::make($request->password);
                $data['created_by'] = Auth::user()->id;
                    $data['organization_id'] = $request->organization_id;
                    MailSetting::create($data);
                    return Redirect::route('mail.index')->with('message', 'Mail Settings Created Successfully!');
            }else{
                return Redirect::back()->with('message', 'Your Mail Settings Exits, Please Update Your Settings!!');
            }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\MailSetting  $mailSetting
     * @return \Illuminate\Http\Response
     */
    public function show(MailSetting $mailSetting)
    {
        dd('ok');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\MailSetting  $mailSetting
     * @return \Illuminate\Http\Response
     */
    public function edit(MailSetting $mailSetting, $id)
    {
        $data = MailSetting::find($id);
        $data['title'] = 'Edit Mail Settings';
        $data['organizations'] = Organization::all();
        return Inertia::render('mailSettings/edit', ['data' => $data]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\MailSetting  $mailSetting
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, MailSetting $mailSetting, $id)
    {

       // dd($request->all());
          // dd($request->all());
          Validator::make($request->all(), [
            'protocol' => ['required'],
            'type' => ['required'],
            'host' => 'required|url',
            'port' => 'required|min:4|regex:/[0-9]/',
            'email' => 'required|email',
        ])->validate();

        $data = $request->all();
        $data['updated_by'] = Auth::user()->id;
        $data['password'] = Hash::make($request->password);
       $result =  MailSetting::find($id)->update($data);
       if($result == null){
        return Redirect::back()->with('message', 'Your mail settings update not successfully');
       }else{
        return Redirect::back()->with('message', 'Your mail settings update successfully');
       }


        // $getOrg =  MailSetting::where('organization_id', $request->input('organization_id'))->first();
        //     if($getOrg == null){
        //         $data['password'] = Hash::make($request->password);
        //         $data['created_by'] = Auth::user()->id;
        //             $data['organization_id'] = $request->organization_id;
        //             MailSetting::create($data);
        //             return Redirect::route('mailSettings.index')->with('message', 'Mail Settings Created Successfully!');
        //     }else{
        //         return Redirect::back()->with('message', 'Your Mail Settings Exits, Please Update Your Settings!!');
        //     }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\MailSetting  $mailSetting
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $check = MailSetting::find($id);
        // if ($check) {
        //     return redirect()->back()->with('message', 'You Can Not Delete This Category');
        // } else {
            $check->delete();
            return redirect()->back()->with('message', 'Mail Deleted Successfully.');
     //   }
    }
}
