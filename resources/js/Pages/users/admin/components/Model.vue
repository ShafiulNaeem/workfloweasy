<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
<!--        Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2 v-if="createMode">{{ title }}</h2>
                    <h2 v-else>{{ data.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a v-if="editMode" :href="route('admins.show',data.id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                        <a v-else :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Manage Users</a>
                    </nav>
                </div>
            </div>
        </div>
<!--        Navbar top End-->


        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item"> {{title}}</li>
                <li v-if="!createMode" class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <div class="register-title">
                <h4>User Update</h4>
            </div>
            <form class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6">
                    <div>
                        <div class="form-group">
                            <label>Name <span class="text-red">*</span></label>
                            <input :class="viewMode?'disabled': ''" class="form-control" type="text"  v-model="form.name"/>
                            <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                        </div>
                    </div>

                    <div>
                        <div class="form-group">
                            <label> Email <span class="text-red">*</span></label>
                            <input :class="viewMode?'disabled': ''" class="form-control" type="email" v-model="form.email"/>
                            <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                        </div>
                    </div>

                     <div v-show="createMode">
                        <div class="form-group">
                            <label>Password <span class="text-red">*</span></label>
                            <input class="form-control" :type="type" v-model="form.password"/>
                            <span @click="showPassword"
                                  :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>

                        </div>
                    </div>

                    <div>
                        <div class="form-group">
                                <label>Roles <span class="text-red">*</span></label>
                                    <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.role_id">
                                        <option v-for="role in data.roles" :value="role.id" :key="role.id">{{role.name}}</option>
                                    </select>
                                    <Select2 v-show="!viewMode"  v-model="form.role_id"
                                             :options="myOptions"/>
                                    <div class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6">
                    <div v-show="!createMode">
                        <div class="form-group">
                            <label>User Code <span class="text-red">*</span></label>
                            <input class="form-control" disabled type="text"  v-model="form.user_code"/>
                        </div>
                    </div>

                    <div>
                        <div class="form-group">
                            <label>Phone <span class="text-red">*</span></label>
                            <input :class="viewMode?'disabled': ''" class="form-control" type="number"  v-model="form.phone"/>
                             <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                        </div>
                    </div>
                    <div>
                        <div class="form-group">
                            <label>Status</label>
                            <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.status">
                                <option value="1" >Active</option>
                                <option value="2" >InActive</option>
                            </select>
                            <Select2  v-show="!viewMode" v-model="form.status"
                                     :options="statusOption"/>
                            <div class="text-danger" v-if="errors.status">{{ errors.status[0] }}</div>
                        </div>
                    </div>
                    <div v-show="createMode">
                        <div class="form-group">
                            <label>Confirm Password <span class="text-red">*</span></label>
                            <input class="form-control" :type="con_type" v-model="form.confirm_password"/>
                            <span @click="showConfirmPassword"
                                  :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                  class="field-icon toggle-password"
                            ></span>
                            <div class="text-danger" v-if="errors.confirm_password">{{ errors.confirm_password[0] }}</div>
                        </div>
                    </div>

                 

                    <div class="m-t-50 text-center">
                        <!--Create button start-->
                        <button
                            type="button"
                            class="save"
                            v-show="createMode"
                            wire:click.prevent="store()"
                            @click="save(form)"
                        >
                            Save
                        </button>
                        <button
                            type="button"
                            class="save_create"
                            wire:click.prevent="store()"
                            v-show="createMode"
                            @click="saveAndAnother(form)"
                        >
                            Create & Another User
                        </button>

                        <!--view button start-->
                        <button style="margin-top: 20px;"
                                type="button" class="save_view"
                                v-show="viewMode"
                                @click="editPassword"

                        >Edit Password</button>
                        <button style="margin-top: 20px;"
                                type="button" class="save_create"
                                v-show="viewMode"
                                @click="changePassword"

                        >Reset Password</button>
                        <button style="margin-top: 20px;"
                                type="button" class="save"
                                v-show="viewMode"
                                @click="Edit"

                        >Edit Personal</button>

                        <button style="margin-top: 20px;"
                                type="button" class="save"
                                v-show="editMode"
                                @click="update(form)"

                        >Update</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        Select2
    },
    props: ['data', 'errors','createMode','viewMode', 'editMode', 'link', 'title', 'label'],
    data() {
        return {
            myOptions:[{id: null, text: ''}],
            statusOption:[
                {id:1, text: 'Active'},
                {id:2, text: 'InActive'}
            ],
            isOpen: false,
            photo: '',
            form: {
                id: undefined,
                name: null,
                email: null,
                phone: null,
                password: null,
                is_active: 1,
                status:1,
                role_id:null,
                user_code: this.data.code,
                // create_another: null
                index:null

            },
            type:'password',
            con_type:'password'
        }
    },
    created() {
        if (this.editMode) {
            this.form = this.data

        }

        if (this.viewMode) {
            this.form = this.data
        }

        let i = 0
        for(i=0; i<this.data.roles.length; i++){
            this.myOptions.push({
                id: this.data.roles[i].id,
                text: this.data.roles[i].name
            })
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
        save: function (params) {
            this.form.index = 'index'
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.user_id || '')
            data.append('user_code', params.user_code || '')
            data.append('status', params.status || '')
            data.append('role_id', params.role_id || '')
            data.append('index', params.index || '')
            this.$inertia.post('/admins', params)

        },
        saveAndAnother: function (params) {

            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.user_id || '')
            data.append('user_code', params.user_code || '')
            data.append('status', params.status || '')
            data.append('role_id', params.role_id || '')

            this.$inertia.post('/admins', params)
            this.form ={};
        },
        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.editMode = true;
            this.openModal();
        },

        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.user_id || '')
            data.append('user_code', params.user_code || '')
            data.append('status', params.status || '')
            data.append('role_id', params.role_id || '')
            data.append('_method', 'PUT')
            this.$inertia.patch('/admins/' + params.id, params)
            // console.log('clicked');
        },
        Edit(){
            this.$inertia.get('/admins/' + this.data.id +'/edit')
        },
        changePassword(){
            this.$inertia.get('/admin/reset/' + this.data.id)
        },
        editPassword(){
            this.$inertia.get('/admins/password/' + this.data.id)
        },

    }
}
</script>
