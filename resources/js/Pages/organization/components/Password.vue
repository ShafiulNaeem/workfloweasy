<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ data.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route('organization-users.show',data.id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item">Organization</li>
                <li v-show="changePassMode" class="breadcrumb-item"> {{title}}</li>
                <li  class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>
        <!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Reset Password</h4>
            </div>
            <form action="" class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6 " style="margin: 0 auto;">
                    <div class="form-group" hidden>
                        <label for="exampleFormControlInput1">Email <span class="text-red">*</span></label>
                        <input type="email" required class="form-control" id="exampleFormControlInput2" v-model="form.email" placeholder="Email:">
                        <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                    </div>

<!--                    <div class="form-group" v-show="changePassMode">-->
<!--                        <label for="inputPassword5">Old Password <span class="text-red">*</span></label>-->
<!--                        <input :type="old_type" id="inputPassword5" v-model="form.old_password" class="form-control" aria-describedby="passwordHelpBlock" placeholder=" password:">-->
<!--                        <span @click="showOldPassword"-->
<!--                              :class="old_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"-->
<!--                              class="field-icon toggle-password"-->
<!--                        ></span>-->
<!--                        <div class="text-danger" v-if="errors.old_password">{{ errors.old_password[0] }}</div>-->

<!--                    </div>-->
                    <div class="form-group">
                        <label for="inputPassword5">New Password <span class="text-red">*</span></label>
                        <input :type="type" id="inputPassword5" v-model="form.password" class="form-control" aria-describedby="passwordHelpBlock" placeholder=" password:">
                        <span @click="showPassword"
                              :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                              class="field-icon toggle-password"
                        ></span>
                        <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>

                    </div>

                    <div class="form-group">
                        <label for="inputPassword5">Confirm Password <span class="text-red">*</span></label>
                        <input :type="con_type" v-model="form.confirm_password" id="inputPassword5" class="form-control" aria-describedby="passwordHelpBlock" placeholder="Confirm password">
                        <span @click="showConfirmPassword"
                              :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                              class="field-icon toggle-password"
                        ></span>
                        <div class="text-danger" v-if="errors.confirm_password">{{ errors.confirm_password[0] }}</div>
                    </div>
<!--                    <input type="hidden" v-model="form.user_id">-->

                    <!--Edit button start-->
                    <button
                            type="button" class="save_role"
                            v-show="changePassMode"
                            @click="update(form)"
                    >Reset</button>
                    <!--Edit button end-->
                </div>
            </form>
        </div>


    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";

export default {
    name: "Password",
    components: {
        Alert,
        datetime: Datetime
    },
    props: ['data', 'errors','changePassMode', 'link', 'title', 'label'],
    data () {
        return {
            form: {
                id: this.data.id,
                email: null,
                // old_password: null,
                password: null,
                confirm_password: null,
            },
            type:'password',
            con_type:'password',
            old_type:'password'
        }
    },
    created () {
        if (this.changePassMode) {
            this.form = this.data
        }
        // if (this.resetPassMode) {
        //     this.form = this.data
        // }
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
        reset: function () {
            this.form = {}
        },
        update: function (params) {
            var data = new FormData()
            data.append('email', params.email || '')
            // data.append('old_password', params.old_password || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('id', params.id || '')

            this.$inertia.post('/organization-users/changePasUpdate',data)
        }
    }

}
</script>

<style scoped>

</style>
