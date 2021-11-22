<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class TaskNotification extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($data)
    {
        $this->emailData = $data;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $subject = 'WorkFlowEasy Task Notification'.' '. $this->emailData->taskdetails->name;
        return $this->from('noreply@workfloweasy.ca','WorkFlowEasy')->subject($subject)->markdown('emails.task.notification',[
            'email_data' => $this->emailData,
            'message' => 'It is Your Task Man. Do First'
        ]);
    }
}
