<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Site Settings Defaults
    |--------------------------------------------------------------------------
    |
    */

    'menu_access' => [
        'admin' => [
            'user_management','organization_management',
            'dashboard','task_management','dashboard_calendar','dashboard_email',
            'data_management',
            'form_management','form_categories','form_departments','form_templates','form_automation',
            'report_management','report_dashboard','report_template','report_automation',

            'settings','settings_department','staff_management',
            'settings_activity','settings_mail','settings_types','categories'
        ],
        'owner' => [
            'dashboard','task_management','dashboard_calendar','dashboard_email',
            'data_management',
            'form_management','form_categories','form_departments','form_automation',
            'report_management',

            'settings','settings_department','staff_management','settings_billing',
            'settings_activity','settings_integration','settings_mail','settings_types'
        ],
        'staff' => [
            'dashboard','task_management','dashboard_calendar','dashboard_email',
            'data_management',
            'form_management','form_categories','form_departments','form_automation',
            'report_management',
            'settings','settings_department','staff_management','settings_activity','settings_types',
        ],
        'member' => [
            'dashboard','task_management','dashboard_calendar','dashboard_email',
            'form_management',
            'report_management',
            'settings','settings_activity'
        ],
    ],

];
