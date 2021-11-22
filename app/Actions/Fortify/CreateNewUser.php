<?php

namespace App\Actions\Fortify;

use App\Models\Category;
use App\Models\Department;
use App\Models\FormDepartment;
use App\Models\Organization;
use App\Models\OrganizationGroup;
use App\Models\Staff;
use App\Models\Subscription;
use App\Models\Type;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Laravel\Fortify\Contracts\CreatesNewUsers;

class CreateNewUser implements CreatesNewUsers
{
    use PasswordValidationRules;

    /**
     * Validate and create a newly registered user.
     *
     * @param  array  $input
     * @return \App\Models\User
     */
    public function create(array $input)
    {
        Validator::make($input, [
            'name' => ['required'],
            'email' => 'required|email|unique:users,email|unique:organizations,email',
            'phone' => 'required|min:8|unique:organizations,phone|regex:/^([0-9\s\-\+\(\)]*)$/',
            'contact_person_email' => 'required|email|unique:organizations,contact_person_email',
            'password' => $this->passwordRules(),
        ])->validate();

        $data = $input;
        $data['password'] = Hash::make($data['password']);

//      $data['user_id'] = $user->id;
        $subscription = Subscription::where('name','Enterprise')->first();
        $data['subscriptions_id'] = $subscription->id;
        $data['is_active'] = true;
        $data['status'] = 1;
        $data['code'] = mt_rand(1000000, 9999999);
        $defaultOrganization = OrganizationGroup::all()->where('is_default','=',1)->sortByDesc('created_at')->first();
        $data['organization_groups_id'] = $defaultOrganization->id;

        $org = Organization::create($data);

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $data['password'],
            'role_id' => '3',
            'user_type'  => 'owner',
            'organization_id'  => $org->id,
        ]);

        $formDepartment = FormDepartment::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $user->id
        ]);

        $category = Category::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $user->id
        ]);

        $department = Department::create([
            'name' => 'Default',
            'organization_id'  =>$org->id,
            'created_by' => $user->id
        ]);
        $type = Type::create([
            'name' => 'Default',
            'organization_id' => $org->id,
            'created_by' => $user->id
        ]);

        $staff = Staff::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'role_id' => '7',
            'organization_id' => $org->id,
            'user_id' => $user->id,
        ]);

        // create many to many table data
        $staff->departments()->sync($department->id);
        $staff->categories()->sync($category->id);
        $staff->types()->sync($type->id);

        return $user;
    }
}
