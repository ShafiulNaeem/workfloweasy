<!DOCTYPE html>
<html lang="en">
<!-- login23:11-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <link rel="icon" href="{{ asset('assets/images/favicon.ico') }}" type="image/gif" sizes="16x16">
    <title>Workflow Easy</title>
    <link rel="stylesheet" type="text/css" href="{{asset('assets/css/bootstrap.min.css')}}">
    <link rel="stylesheet" type="text/css" href="{{asset('assets/css/font-awesome.min.css')}}">
    <link rel="stylesheet" type="text/css" href="{{asset('assets/css/style.css')}}">
    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.min.js"></script>
    <script src="assets/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="main-wrapper account-wrapper">
    <div class="account-page">
        <div class="account-center">
            <div class="container-full">
                <div class="row login-wrapper">
                    <div class="account-box col-12 col-md-6  ">
                        <div class="conatiner-wrapper">
                            <div class="account-logo">
                                <img class="login-logo" src="assets/images/LoginPage.png" alt="" srcset="">
                            </div>
                            <x-jet-validation-errors class="mb-4" />
                                @if (session('status'))
                                    <div style="color: red;">*
                                        {{ session('status') }}
                                    </div>
                                @endif
                            <form method="POST" action="{{ route('login') }}" class="form-signin">
                                @csrf
                                <div class="form-group">
                                    <label>Email</label>
                                    <input name="email" type="text" autofocus="" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input name="password" type="password" class="form-control" required>
                                </div>
                                <div class="checkbox checkbox_hover">
                                    <label><input type="checkbox"> Remember me</label>
                                    <span class="float-right">
                                         @if (Route::has('password.request'))
                                            <a style="text-decoration: none" href="{{ route('password.request') }}">
                                            {{ __('Forgot?') }}
                                        </a>
                                        @endif
                                    </span>
                                </div>
{{--                                <div class="button-wp bg-danger d-flex">--}}
{{--                                    <div class="form-group text-left forget-text">--}}
{{--                                        @if (Route::has('password.request'))--}}
{{--                                            <a href="{{ route('password.request') }}">Forgot your password?</a>--}}
{{--                                        @endif--}}
{{--                                    </div>--}}

{{--                                    <div class="form-group rlt-btn">--}}
{{--                                        <button type="submit" class=" btn btn-dark">Login</button>--}}
{{--                                    </div>--}}
{{--                                </div>--}}
                                <div class="login_submit" style="margin-top: 8px;">

                                        <button class="btn btn-dark float-right" type="submit">login</button>
                                    <a style="text-decoration: none; padding-top: 5px; padding-right: 10px;" class="float-right" href="{{route('register')}}">New Registration | </a>

                                </div>
                            </form>
                        </div>

                    </div>
                    <div class="login-image col-12 col-md-6">
                        <div class="images-wrapper">
                            <img src="{{asset('assets/images/login.png')}}" alt="">
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
<script src="assets/js/jquery-3.2.1.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/app.js"></script>
</body>
<!-- login23:12-->
</html>

