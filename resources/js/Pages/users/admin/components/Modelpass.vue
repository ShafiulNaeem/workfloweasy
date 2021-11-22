<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
<!--        Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ this.data.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route('admins.show',data.id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                    </nav>
                </div>
            </div>
        </div>
<!--        Navbar top End-->


        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-show="!editMode" class="breadcrumb-item">  {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item">  {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item">  {{this.data.name}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <div class="register-title">
                <h4>Change Password</h4>
            </div>
            <form class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6">
                    <div v-show="editMode">
                        <div class="form-group">
                            <label>Old Password</label>
                            <input class="form-control" :type="old_type" v-model="form.old_password"/>
                            <span @click="showOldPassword"
                                  :class="old_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <div class="text-danger" v-if="errors.old_password">{{ errors.old_password[0] }}</div>
                        </div>
                    </div>
                     <div v-show="editMode">
                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <input class="form-control" :type="con_type" v-model="form.confirm_new_password"/>
                            <span @click="showConfirmPassword"
                                  :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                             <div class="text-danger" v-if="errors.confirm_new_password">{{ errors.confirm_new_password[0] }}</div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div v-show="editMode">
                        <div class="form-group">
                            <label>New Password</label>
                            <input class="form-control" :type="type" v-model="form.new_password"/>
                            <span @click="showPassword"
                                  :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <div class="text-danger" v-if="errors.new_password">{{ errors.new_password[0] }}</div>
                        </div>
                    </div>

                    <div class="m-t-50 text-center">
                        <button
                            type="button"
                            class="save"
                            v-show="editMode"
                            wire:click.prevent="store()"
                            @click="update(form)"
                        >
                            Update
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'

export default {
 components: {
        Alert
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data() {
        return {
            isOpen: false,
            photo: '',
            form: {
                id: undefined,
                is_active: 1,
                role_id: 6,
                old_password: null,
                new_password: null,
                confirm_new_password: null,
                user_id: this.data.code,

            },
            type:'password',
            con_type:'password',
            old_type:'password'
        }
    },
    created() {
        if (this.editMode) {
            this.form = this.data
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

        reset: function () {
            this.form = {
                name: null,
                email: null,
                is_active: 1,
                role_id: 6,
            }
        },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },

        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.editMode = true;
            this.openModal();
        },
        update: function (params) {

            var data = new FormData()
            data.append('id', params.id || '')
            // data.append('name', params.name || '')
            // data.append('email', params.email || '')
            // data.append('phone', params.phone || '')
            data.append('old_password', params.old_password || '')
            data.append('new_password', params.new_password || '')
            data.append('confirm_new_password', params.confirm_new_password || '')
            // data.append('is_active', params.is_active || '')
            // data.append('role_id', params.role_id || '')
             data.append('user_id', params.user_id || '')
             //data.append('_method', 'PUT')
             this.$inertia.post('/admins/user/changepass', data)
        },
        // updatePer: function(){
        //     console.log('clicked per');
        // },
        EditPass: function(){
            console.log('clicked pass');
        },
        resetPass: function(){
            console.log('clicked res');
        }
    }
}
</script>
