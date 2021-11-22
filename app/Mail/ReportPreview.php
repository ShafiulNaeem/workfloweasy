<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ReportPreview extends Mailable
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
//        dd( $this->emailData['pdf']);
        return $this->from('noreply@workfloweasy.ca','WorkFlowEasy')->subject('Report From WorkFlowEasy')
            ->view('emails.report_preview_email',[
            'email_data' => $this->emailData,
            'message' => 'Report Created'])
            ->attachData($this->emailData['pdf']->output(), 'Report.pdf', [
                'mime' => 'application/pdf',
            ]);

    }
}
