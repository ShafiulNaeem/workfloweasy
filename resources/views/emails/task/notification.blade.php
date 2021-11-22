<!DOCTYPE html>
<html lang="en-US">
<head>
    <meta charset="utf-8">
    <style type="text/css">
        body {
            margin: 0 !important;
            padding: 0 !important;
            width: 100% !important;
            color: #172b4d !important;
            font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
            font-size: 14px !important;
        }
        .card {
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2)!important;
            transition: 0.3s !important;
            width: 100% !important;
            border-radius: 6px; border: solid 2px #ebecf0;
            border-collapse: separate;
            }

            .card:hover {
                box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            }

            .container {
                padding: 2px 16px;
            }
            /*table*/
        #customers {
            font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
            border-collapse: collapse;
            /*width: 100%;*/
        }
        #customers td {
            font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
            color: #5e6c84;
        }

        #customers th {
            /*padding-top: 12px;*/
            /*padding-bottom: 12px;*/
            text-align: left;
            color: #172b4d !important;
        }
        a{
            color: #0052cc;
            font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
        }

</style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            @if($email_data->status == 'COMPLETED')
                <p style="font-size: 14px !important;">This task has been <b>COMPLETED</b>.</p>
            @else
                <p style="font-size: 14px !important;">This task has been created <br>This task is <b>now assigned to you</b>.</p>
            @endif

        </div>
        <div class="card">
            <div class="container">
                <table id="customers">
                    <tr>
                        <td><a style="text-decoration-line: none;" href="{{route('dashboard')}}" target="_blank">WorkFlowEasy</a></td>
                        <td  style=" padding-left: 10px;">/</td>
{{--                        <td><img src="{{asset('storage/app/public/image/emailTask.png')}}" style="width: 20px; padding-left: 10px;"></td>--}}
                        <td><a style="text-decoration-line: none; padding-left: 5px;" href="{{route('tasks.index')}}" target="_blank">{{$email_data->taskdetails->name}}</a></td>
                    </tr>
                </table>
                <table id="customers" style="margin-bottom: 15px;">
                    <tr>
                        <th style="padding-bottom: 10px; color: #172b4d; font-size: 24px; font-weight: 500; line-height: 1.250; letter-spacing: -0.010em; text-transform: none">{{$email_data->taskdetails->instruction}}</th>
                    </tr>
                    <tr>
                        <td><a style="text-decoration-line: underline;" href="{{route('tasks.show',$email_data->id)}}" target="_blank">View Task</a></td>
                    </tr>
                </table>
                @if($email_data->status != 'COMPLETED')
                    <table id="customers">
                        <tr>
                            <th style="padding-top: 12px; padding-bottom: 15px; color: #172b4d; font-size: 20px; font-weight: 500; line-height: 1.500; letter-spacing: -0.008em; text-transform: none">
                                Task created
                            </th>
                        </tr>
                    </table>
                @endif

                <table id="customers" style="margin-bottom: 5px;">
                    <tr>
                        <td><b>{{$email_data->created_by_name?$email_data->created_by_name->name:''}}</b> created this task on {{\Carbon\Carbon::parse($email_data->created_at)->format('F j, Y, g:i:s a')}}</td>
                    </tr>
                </table>
                <table id="customers" style="margin-bottom: 50px;">
                    @if($email_data->status == 'COMPLETED')
                        <tr>
                            <td style="padding: 5px;">Task Status</td>
                            <td  style="padding: 5px;">: <span style="
                                        padding-right: 3px;
                                        border-radius: 3px;
                                        box-sizing: border-box;
                                        background-color: #179f7b;
                                        font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
                                        color: cornsilk;
                                        padding-left: 3px"
                                >{{$email_data->status}}</span></td>
                        </tr>
                    @else
                        <tr>
                            <td style="padding: 5px;">Instruction</td>
                            <td  style="padding: 5px;">: {{$email_data->taskdetails->instruction}}</td>
                        </tr>
                    @endif

                    <tr>
                        <td style="padding: 5px;">Group</td>
                        <td  style=" padding: 5px;">: {{$email_data->task_reference_type}}</td>
                    </tr>

                    <tr>
                        <td style="padding: 5px;">Assignee</td>
                        <td style="padding: 5px;">:
                            @foreach($email_data->get_taskdetails->departments as $department)
                                <span style="
                                        padding-right: 3px;
                                        border-radius: 3px;
                                        box-sizing: border-box;
                                        background-color: #179f7b;
                                        font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
                                        color: cornsilk;
                                        padding-left: 3px"
                                >{{$department->name}}</span>
                            @endforeach
                            <b>(departments)</b>
                        </td>
                    </tr>
                    @if($email_data->status != 'COMPLETED')
                        <tr>
                            <td style="padding: 5px;">Created</td>
                            <td  style=" padding: 5px;">: {{\Carbon\Carbon::parse($email_data->created_at)->format('F j, Y, g:i:s a')}}</td>
                        </tr>
                    @endif

                    <tr>
                        <td style="padding: 5px;">Due Date</td>
                        <td  style="padding: 5px;">: {{\Carbon\Carbon::parse($email_data->due_date)->format('F j, Y, g:i:s a')}}</td>
{{--                        isoFormat('MMMM Do YYYY, h:mm:ss a')--}}
                    </tr>

                    @if($email_data->status == 'COMPLETED')
                        <tr>
                            <td style="padding: 5px;">Completed</td>
                            <td  style=" padding: 5px;">: {{\Carbon\Carbon::parse($email_data->end_time)->format('F j, Y, g:i:s a')}}</td>
                        </tr>
                    @endif

                    @if($email_data->status == 'COMPLETED')
                        <tr>
                            <td style="padding: 5px;">Submitted By</td>
                            <td  style="padding: 5px;">: {{$email_data->started_by?$email_data->started_by->name:''}}</td>
                        </tr>
                    @else
                        <tr>
                            <td style="padding: 5px;">Reporter</td>
                            <td  style="padding: 5px;">: {{$email_data->created_by_name?$email_data->created_by_name->name:''}}</td>
                        </tr>
                    @endif

                </table>
            </div>
        </div>
        <div class="col-md-12">
            <p style="font-size: 14px !important;">This message was sent by <b>WorkflowEasy</b></p>
        </div>
    </div>
</div>
</body>
</html>
