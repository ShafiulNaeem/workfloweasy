<!DOCTYPE html>
<html  lang="en-US">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Workflow Easy</title>

    <!-- Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Styles -->

    <!-- Theme css -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="icon" href="{{ asset('assets/images/favicon.ico') }}" type="image/gif" sizes="16x16">

    <link rel="stylesheet" href="{{ asset('assets/css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/font-awesome.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/style.css') }}">
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
<div>
    <div class="row">
        <div
            @if($data['report']->type == 'COMPARE')
            class="col-md-6"
            @else
            class="col-md-11"
            @endif
            style="width: 50%; float: left"
        >
            <div class="col-md-12">
                <p><b>{{$data['date_1']?$data['date_1']->formsFields->field_name:''}}: </b>
                    {{\Carbon\Carbon::parse($data['date_1']?$data['date_1']->start_date:'')->format('F j, Y, g:i:s a')}} <b>To</b>
                    {{\Carbon\Carbon::parse($data['date_1']?$data['date_1']->end_date:'')->format('F j, Y, g:i:s a')}}
                    <br>
                    <span>Total Records: <b>{{$data['total_records_form_one']}}</b></span>
                </p>
            </div>

            <div class="table-responsive table1 scroll">
                <ul style="float:left; list-style:none" class="list-group">
                    <li class="font-weight-bold">#</li>

                    @if($data['representation']->total == 1)
                        <li class="font-weight-bold" >Total</li>
                    @endif
                    @if($data['representation']->average == 1)
                        <li class="font-weight-bold" >Average</li>
                    @endif
                    @if($data['representation']->lowest == 1)
                        <li class="font-weight-bold" >Lowest</li>
                    @endif
                    @if($data['representation']->highest == 1)
                        <li class="font-weight-bold" >Highest</li>
                    @endif

                </ul>
                <div class="d-flex">
                    @foreach($data['form_one'] as $row)
                        <ul style="list-style:none; float:left; "class="list-group ">
                            <li class="font-weight-bold">{{$row->field_label}}</li>

                            @if($data['representation']->total == 1)
                                <li>{{$row->sum?number_format((float)$row->sum, 2, '.', ''):'Empty'}}</li>
                            @endif
                            @if($data['representation']->average == 1)
                                <li>{{$row->avg?number_format((float)$row->avg, 2, '.', ''):'Empty'}}</li>
                            @endif
                            @if($data['representation']->lowest == 1)
                                <li>{{$row->min?number_format((float)$row->min, 2, '.', ''):'Empty'}}</li>
                            @endif
                            @if($data['representation']->highest == 1)
                                <li>{{$row->max?number_format((float)$row->max, 2, '.', ''):'Empty'}}</li>
                            @endif
                        </ul>
                    @endforeach
                </div>
            </div>
        </div>
        @if($data['report']->type == 'COMPARE')

            <div class="col-md-6" style="width: 50%; float: left">
                <div class="col-md-12">
                    <p><b>{{$data['date_2']?$data['date_2']->formsFields->field_name:''}}: </b>
                        {{\Carbon\Carbon::parse($data['date_2']?$data['date_2']->start_date:'')->format('F j, Y, g:i:s a')}} <b>To</b>
                        {{\Carbon\Carbon::parse($data['date_2']?$data['date_2']->end_date:'')->format('F j, Y, g:i:s a')}}
                        <br>
                        <span>Total Records: <b>{{$data['total_records_form_two']}}</b></span>
                    </p>
                </div>

                <div class="table-responsive table1 scroll">
                    <ul style="float:left; list-style:none" class="list-group">
                        <li class="font-weight-bold">#</li>

                        @if($data['representation']->total == 1)
                            <li class="font-weight-bold" >Total</li>
                        @endif
                        @if($data['representation']->average == 1)
                            <li class="font-weight-bold" >Average</li>
                        @endif
                        @if($data['representation']->lowest == 1)
                            <li class="font-weight-bold" >Lowest</li>
                        @endif
                        @if($data['representation']->highest == 1)
                            <li class="font-weight-bold" >Highest</li>
                        @endif

                    </ul>
                    <div class=" d-flex">
                        @foreach($data['form_two'] as $row)
                            <ul style="list-style:none; "class="list-group ">
                                <li class="font-weight-bold" >{{$row->field_label}}</li>

                                @if($data['representation']->total == 1)
                                    <li>{{$row->sum?number_format((float)$row->sum, 2, '.', ''):'Empty'}}</li>
                                @endif
                                @if($data['representation']->average == 1)
                                    <li>{{$row->avg?number_format((float)$row->avg, 2, '.', ''):'Empty'}}</li>
                                @endif
                                @if($data['representation']->lowest == 1)
                                    <li>{{$row->min?number_format((float)$row->min, 2, '.', ''):'Empty'}}</li>
                                @endif
                                @if($data['representation']->highest == 1)
                                    <li>{{$row->max?number_format((float)$row->max, 2, '.', ''):'Empty'}}</li>
                                @endif
                            </ul>
                        @endforeach
                    </div>
                </div>

        </div>
        @endif
    </div>
</div>
<!-- Theme js -->
<script src="{{ asset('assets/js/jquery-3.2.1.min.js') }}"></script>
<script src="{{ asset('assets/js/popper.min.js') }}"></script>
<script src="{{ asset('assets/js/bootstrap.min.js') }}"></script>
</body>
</html>
