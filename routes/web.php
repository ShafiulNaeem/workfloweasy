<?php

use App\Http\Controllers\FormDepartmentController;
use App\Http\Controllers\OrganizationGroupController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\StoreController;
use App\Http\Controllers\AdminUserController;
use App\Http\Controllers\OrganizationUserController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\StaffController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\FormController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FormResponseController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\TypeController;
use App\Http\Controllers\MailSettingController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\FormAutomationController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\ReportAutomationController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use Illuminate\Foundation\Auth\EmailVerificationRequest;

Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill();

    return redirect('/dashboard');
})->middleware(['auth'])->name('verification.verify');

Route::get('/', function () {
    return redirect()->route('login');
});

//Iframe
Route::get('/form/iframe/{slug}',[FormResponseController::class, 'iframe'])->name('forms.iframe');

Route::get('/form/response/{slug}',[FormResponseController::class, 'response'])->name('forms.response');
Route::get('/form/response/{slug}/success',[FormResponseController::class, 'success'])->name('forms.responses');
Route::post('/form-responses',[FormResponseController::class, 'store']);
Route::post('/form-responses-protect',[FormResponseController::class, 'protectForm']);

Route::post('/form/file-upload', [FormResponseController::class, 'fileUpload']);

Route::get('/dashboard',[DashboardController::class, 'dashboard'])->name('dashboard')->middleware(['auth:sanctum', 'verified']);


Route::middleware(['auth:sanctum', 'verified'])->get('/changePassword', function () {
    return Inertia\Inertia::render('Profile/UpdatePasswordForm');
})->name('changePassword');

Route::group(['middleware' => 'auth'], function () {

    /* #################### Start User Management #################### */

    Route::resource('users', UserController::class);

    /* ******************** End User Management *********************** */


    /* #################### Start Change/Reset Password #################### */



    /* ******************** End Change/Reset Password *********************** */
    Route::get('/organization-users/changePassword/{id}',[OrganizationUserController::class, 'changePassword'])->name('organization.changePassword');
    Route::post('/organization-users/changePasUpdate', [OrganizationUserController::class, 'changePasUpdate'])->name('changePasUpdate');

    /* #################### Start Task Management #################### */

    Route::get('/tasks/pending-tasks',[TaskController::class, 'pending_task'])->name('tasks.pending_task');
    Route::get('/taskDashboard',[TaskController::class, 'taskDashboard'])->name('tasks.taskDashboard');
    Route::resource('tasks', TaskController::class);
    Route::get('/tasks/startNow/{id}',[TaskController::class, 'startNow'])->name('tasks.startNow');
    Route::post('/tasks/changeStatus', [TaskController::class, 'changeStatus'])->name('tasks.changeStatus');

    /* ******************** End Task Management ******************** */



    /* #################### Start Common Settings #################### */
    Route::resource('roles', RoleController::class);
    Route::resource('permissions', PermissionController::class);
    Route::resource('categories', CategoryController::class);
    //Route::resource('subscriptions', SubscriptionController::class);
    Route::resource('admins', AdminUserController::class);
    Route::get('/organization/get-data/{id}',[OrganizationUserController::class, 'getData']);
    Route::resource('organization-users', OrganizationUserController::class);
    Route::get('/getdepartments/{id}',[StaffController::class, 'departments'])->name('staff.departments');
    Route::get('/staff/view/{id}',[StaffController::class, 'staffView'])->name('staffs');
    Route::get('/member/edit/{id}',[StaffController::class, 'staffEdit'])->name('member.edit');
    Route::get('/member/password/change/{id}',[StaffController::class, 'passwordEdit'])->name('member.password');
    Route::post('/staffs/pass/update',[StaffController::class, 'passwordUpdate']);
    Route::post('/staffs/pass/reset',[StaffController::class, 'resetPassword'])->name('update.password');
    Route::get('/member/password/reset/{id}',[StaffController::class, 'ResetPassEdit'])->name('member.password.reset');
    Route::get('/staff/edit/{id}',[StaffController::class, 'staffEdit'])->name('edit');
    Route::resource('departments', DepartmentController::class);
    Route::resource('staffs', StaffController::class);

    // form generation routes
    Route::get('/forms/generate', [FormController::class, 'generate'])->name('forms.generate');
    Route::get('/forms/generate/{slug}/add_fields', [FormController::class, 'add_fields'])->name('add_fields');
    Route::get('/forms/generate/{slug}/form_settings', [FormController::class, 'form_settings'])->name('form_settings');
    Route::post('/forms/{form_id}/update-settings', [FormController::class, 'update_settings'])->name('update_settings');
    Route::put('/forms/{form_id}/update-form-info', [FormController::class, 'update_form_info'])->name('update_form_info');

    Route::get('/forms/data', [FormController::class, 'form_data'])->name('forms.form_data');
    Route::post('/forms/create', [FormController::class, 'create'])->name('forms.create');
    Route::get('/forms/precreate', [FormController::class, 'precreate'])->name('forms.precreate');
    Route::get('/getcategories/{id}',[FormController::class, 'categories'])->name('forms.categories');
    Route::get('/get_department/{id}',[FormController::class, 'departments'])->name('forms.departments');
    Route::delete('/forms/{id}/removeField',[FormController::class, 'removeField']);
    Route::resource('forms', FormController::class);
    Route::get('/forms/delete/{id}', [FormController::class, 'destroy'])->name('form.delete');

    Route::delete('/forms/{id}/removeFieldOption',[FormController::class, 'removeFieldOption']);

    // #################################### Form response ####################
//    Route::post('/form/file-upload', [FormResponseController::class, 'fileUpload']);
    Route::post('/form/response/changeStatus', [FormResponseController::class, 'changeStatus'])->name('changeStatus');
    Route::get('/form/response/{response_id}/view-data', [FormResponseController::class, 'viewData'])->name('viewData');
    Route::get('/form/response/{response_id}/edit-data', [FormResponseController::class, 'editData'])->name('editData');
    Route::get('/form/response/{response_id}/submission-data', [FormResponseController::class, 'submissionData'])->name('submissionData');
    Route::post('/form/response/{response_id}/updateData', [FormResponseController::class, 'updateData'])->name('updateData');
    Route::resource('form/response', FormResponseController::class);
    Route::get('/forms/response/{id}', [FormResponseController::class, 'show'])->name('form.response.show');
    /* #################### End Common Settings #################### */
    Route::resource('organization-group', OrganizationGroupController::class);
    Route::resource('form-department', FormDepartmentController::class);
    Route::resource('type', TypeController::class);
    Route::resource('mail', MailSettingController::class);

    /* #################### User Client Manager #################### */
    Route::get('admins/personal/{id}',[ AdminUserController::class, 'editPersonal'])->name('admin/personal');
    Route::get('admins/password/{id}',[ AdminUserController::class, 'editPassword'])->name('admin/password');
    Route::get('admin/reset/{id}',[ AdminUserController::class, 'getResetPassword'])->name('admin/reset');
    Route::post('/admins/reset/pass',[ AdminUserController::class, 'resetPassword']);
    Route::post('/admins/user/changepass',[ AdminUserController::class, 'changePassword'])->name('admin/reset/password');


    // #################################### Form Automation Start ####################

    Route::resource('formAutomation', FormAutomationController::class);

    // #################################### Form Automation end ####################

    // #################################### Form Automation Start ####################

        Route::resource('report', ReportController::class);
        Route::get('reports/generate', [ReportController::class, 'generate'])->name('reports.generate');
        Route::get('reports/generate/{slug}', [ReportController::class, 'edit'])->name('reports.edit');
        Route::get('/category/get-data/{id}',[ReportController::class, 'getCategory']);

        Route::get('reports/generate/{slug}/dataRepresentation', [ReportController::class, 'dataRepresentation'])->name('reports.dataRepresentation');
        Route::post('reports/generate/dataRepresentation/{report_slug}/data-store', [ReportController::class, 'data_store'])->name('reports.data_store');
        Route::get('reports/generate/{report_slug}/filter', [ReportController::class, 'filter'])->name('reports.filter');
        Route::post('/reports/generate/{filter_slug}/preview', [ReportController::class, 'filterStore']);
      //  Route::get('/reports/{report_slug}/preview', [ReportController::class, 'preview']);
        Route::get('/reports/{slug}/preview', [ReportController::class,'preview'])->name('reports.preview');

        // Report Automation
        Route::get('report-automation', [ReportController::class, 'reportAutomationIndex'])->name('reportAutomation.index');
        Route::get('report-automation/create', [ReportController::class, 'create_automation'])->name('reportAutomation.create');
        Route::get('/report-automation/generate',[ReportController::class, 'generateReportAutomation']);
        Route::get('/report-automation/get-report/{id}',[ReportController::class, 'getReport']);
        Route::get('/report-automation/get-report-slug/{id}',[ReportController::class, 'getReportSlug']);
        Route::get('report-automation/{slug}', [ReportController::class, 'reportAutomationShow'])->name('reportAutomation.show');

        Route::get('test', [ReportController::class, 'reportAutomationSchedule'])->name('reportAutomation.schedule');

        //send mail with Pdf
        Route::get('send-email-pdf/{slug}', [ReportController::class, 'send_email_pdf'])->name('pdf');

        //Report Automation History Delete
        Route::delete('report-automation/delete_history/{id}', [ReportController::class, 'ReportAutomationHistoryDelete'])->name('reportAutomation.delete');
//      organization Details
        Route::get('organization/details', [OrganizationUserController::class, 'organization_details'])->name('organization.details');


    // #################################### Form Automation end ####################

     // #################################### Report Automation Start ####################

//     Route::resource('reportAutomation', ReportAutomationController::class);

     // #################################### Report Automation End ####################

});
