<?php

namespace App\Http\Controllers;

use App\Mail\VerificationMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class SendMailController extends Controller
{
    public static function sendVerificationMail($name, $email)
    {
        $data = [
            'name' => $name,
//            'verification_code' => $verification_code
        ];
        //dd($email);
        Mail::to($email)->send( new VerificationMail($data));
    }
}
