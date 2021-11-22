<template>
    <app-layout>
        <div class="page-wrapper user-color">
            <slot name="header"></slot>
            <!-- Navbar top Start-->
            <div class="container-fluid user-bg-title">
                <div class="user-serchbox d-flex">
                    <div class="user-title capi">
                        <h2>Change Password</h2>
                    </div>
                    <div class="searchbox ml-auto">
                        <nav class="navbar user-nav d-flex nav-mr-top">
                            <a :href="route('dashboard')"  class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Dashboard</a>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Navbar top End-->

            <nav aria-label="Page breadcrumb">
                <ol class="breadcrumb padding-top">
                    <li class="breadcrumb-item" aria-current="page">Main</li>
                    <li class="breadcrumb-item">Change Password</li>
                </ol>
            </nav>

            <div class="register-form">
                <jet-action-message :on="form.recentlySuccessful" class="mr-3 ">
                    <p class="text-center text-success">*Your Password Updated Successfully!.</p>
                </jet-action-message>

                <form action="" class="d-md-flex from-wrapper">
                    <div class="col-12 col-md-6 " style="margin: 0 auto;">
                        <div class="form-group">
                            <label for="inputPassword5">Current Password <span class="text-red">*</span></label>
                            <input :type="old_type" id="inputPassword5" v-model="form.current_password" class="form-control" aria-describedby="passwordHelpBlock" placeholder="current password:">
                            <span @click="showOldPassword"
                                  :class="old_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <jet-input-error :message="form.error('current_password')" class="mt-2" />

                        </div>
                        <div class="form-group">
                            <label for="inputPassword5">New Password <span class="text-red">*</span></label>
                            <input :type="type" id="inputPassword5" v-model="form.password" class="form-control" aria-describedby="passwordHelpBlock" placeholder=" password:">
                            <span @click="showPassword"
                                  :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <jet-input-error :message="form.error('password')" class="mt-2" />

                        </div>

                        <div class="form-group">
                            <label for="inputPassword5">Confirm Password <span class="text-red">*</span></label>
                            <input :type="con_type" v-model="form.password_confirmation" id="inputPassword5" class="form-control" aria-describedby="passwordHelpBlock" placeholder="Confirm password">
                            <span @click="showConfirmPassword"
                                  :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <jet-input-error :message="form.error('password_confirmation')" class="mt-2" />
                        </div>

                        <button
                            type="button" class="save_role"
                            @click="updatePassword"
                        >Save</button>
                    </div>
                </form>

            </div>
        </div>
    </app-layout>

</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import JetActionMessage from '@/Jetstream/ActionMessage'
    import JetButton from '@/Jetstream/Button'
    import JetFormSection from '@/Jetstream/FormSection'
    import JetInput from '@/Jetstream/Input'
    import JetInputError from '@/Jetstream/InputError'
    import JetLabel from '@/Jetstream/Label'

    export default {
        components: {
            AppLayout,
            JetActionMessage,
            JetButton,
            JetFormSection,
            JetInput,
            JetInputError,
            JetLabel,

        },

        data() {
            return {
                form: this.$inertia.form({
                    current_password: '',
                    password: '',
                    password_confirmation: '',
                }, {
                    bag: 'updatePassword',
                }),
                type:'password',
                con_type:'password',
                old_type:'password'
            }
        },

        methods: {
            showPassword() {
                if(this.type === 'password') {
                    this.type = 'text'
                }else {
                    this.type = 'password'
                }
            },
            showOldPassword() {
                if(this.old_type === 'password') {
                    this.old_type = 'text'
                }else {
                    this.old_type = 'password'
                }
            },
            showConfirmPassword() {
                if(this.con_type === 'password') {
                    this.con_type = 'text'
                }else {
                    this.con_type = 'password'
                }
            },

            updatePassword() {
                this.form.put(route('user-password.update'), {
                    preserveScroll: true
                }).then(() => {
                    this.$refs.current_password.focus()
                })
            },
        },
    }
</script>
