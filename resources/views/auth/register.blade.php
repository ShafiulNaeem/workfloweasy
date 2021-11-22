<x-guest-layout>
    <x-jet-authentication-card>
        <x-slot name="logo">
            <img src="{{ asset('assets/images/LoginPage.png') }}" alt="" style="height: 88px; width: 224px;">
        </x-slot>

        <x-jet-validation-errors class="mb-4" />

        <form method="POST" action="{{ route('register') }}">
            @csrf

            <div>
                <label for="name">Company Name <span class="text-red">*</span></label>
                <x-jet-input id="name" class="block mt-1 w-full" type="text" name="name" :value="old('name')" required autofocus autocomplete="name" />
            </div>

            <div class="mt-4">
                <label for="email">Email <span class="text-red">*</span></label>
                <x-jet-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required />
            </div>

            <div>
                <label for="phone">Phone <span class="text-red">*</span></label>
                <x-jet-input id="phone" class="block mt-1 w-full" type="text" name="phone" :value="old('phone')" required />
            </div>

            <div>
                <label for="website">Website <span class="text-red">*</span></label>
                <x-jet-input id="website" class="block mt-1 w-full" type="text" name="website" :value="old('website')" required />
            </div>

            <div>
                <label for="contact_person_name">Contact Person Name <span class="text-red">*</span></label>
                <x-jet-input id="contact_person_name" class="block mt-1 w-full" type="text" name="contact_person_name" :value="old('contact_person_name')" required />
            </div>

            <div>
                <label for="contact_person_email">Contact Person Email <span class="text-red">*</span></label>
                <x-jet-input id="contact_person_email" class="block mt-1 w-full" type="text" name="contact_person_email" :value="old('contact_person_email')" required />
            </div>

            <div class="mt-4">
                <label for="password">Password <span class="text-red">*</span></label>
                <x-jet-input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="new-password" />
            </div>

            <div class="mt-4">
                <label for="password_confirmation">Confirm Password <span class="text-red">*</span></label>
                <x-jet-input id="password_confirmation" class="block mt-1 w-full" type="password" name="password_confirmation" required autocomplete="new-password" />
            </div>

            <div class="flex items-center justify-end mt-4">
                <a class="underline text-sm text-gray-600 hover:text-gray-900" href="{{ route('login') }}">
                    {{ __('Already registered?') }}
                </a>

                <x-jet-button class="ml-4">
                    {{ __('Register') }}
                </x-jet-button>
            </div>
        </form>
    </x-jet-authentication-card>
</x-guest-layout>

<style>
    .text-red{
        color: red;
    }
</style>
