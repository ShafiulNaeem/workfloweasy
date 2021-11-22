<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ this.data.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a @click="goBack()" class="btn btn-primary text-white btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-show="editMode" class="breadcrumb-item">Users</li>
                <li v-show="editMode" class="breadcrumb-item"> {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item"> {{this.data.name}}</li>
            </ol>
        </nav>

<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Change Password</h4>
            </div>
            <div class="col-lg-12 col-md-12  from-wrapper">
               
                <form>
                    <div class="row">
                        <!-- <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Confirm Password<span class="text-red">*</span></label>
                                <input class="form-control" :type="con_type" v-model="form.confirm_new_password"/>
                                <span @click="showConfirmPassword"
                                      :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                <div class="text-danger" v-if="errors.confirm_new_password">{{ errors.confirm_new_password[0] }}</div>
                            </div>
                        </div> -->
                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>Old Password</label>
                                <input class="form-control" :type="type" v-model="form.old_password" />
                                <span @click="oldPassword"
                                      :class="type == 'password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                <div class="text-danger" v-if="errors.old_password">{{ errors.old_password[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>New Password</label>
                                <input class="form-control" :type="new_type" v-model="form.new_password" >
                                <span @click="newPassword"
                                      :class="new_type == 'password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                <div class="text-danger" v-if="errors.new_password">{{ errors.new_password[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input class="form-control" :type="con_type" v-model="form.confirm_new_password"/>
                                <span @click="newConfirmPassword()"
                                      :class="con_type == 'password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                 <div class="text-danger" v-if="errors.confirm_new_password">{{ errors.confirm_new_password[0] }}</div>
                            </div>
                        </div>

                    </div>

                    <div class="m-t-20   text-center">
                        <button
                            type="button"
                            class="save"
                            wire:click.prevent="store()"
                            @click="update(form)"
                        >
                            Update
                        </button>

                    </div>
                </form>
            </div>
        </div>

    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import {HTTP} from '@/utils/http-common'

export default {
    components: {
        Alert,
        datetime: Datetime
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            photo: null,
            departments:[],
            form: {
                id: undefined,
                new_password:null,
                confirm_new_password:null,
                department_id: null,
                organization_id: null,
                role_id: null,
            },
            type:'password',
            con_type:'password',
            new_type:'password',
        }
    },
    created () {

        if (this.editMode) {
            this.form = this.data
            this.form.password = null
        }
    },
    methods: {
      goBack: function() {
        window.history.back();
        },
      getDepartments: function () {
          HTTP.get('/getdepartments/'+this.form.organization_id)
              .then((response)=>{
                  this.departments = response.data;
              })
      },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        reset: function () {
            this.form = {}
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
            data.append('new_password', params.new_password || '')
            data.append('old_password', params.old_password || '')
            data.append('confirm_new_password', params.confirm_new_password || '')
            data.append('user_id', params.user_id || '')
            this.$inertia.post('/staffs/pass/update', data)
          //  this.form = {}
        },
        //  showPassword() {
        //     if(this.type === 'password') {
        //         console.log('text');
        //         this.type = 'text'
        //     }else {
        //         console.log('pass');
        //         this.type = 'password'
        //     }
        // },
       // oldPassword
        oldPassword() {
            if(this.type === 'password') {
                this.type = 'text'
            }else {
                this.type = 'password'
            }
              },
          newPassword() {
            if(this.new_type === 'password') {
                this.new_type = 'text'
            }else {
                this.new_type = 'password'
            }
              },
     newConfirmPassword() {
            if(this.con_type === 'password') {
                this.con_type = 'text'
            }else {
                this.con_type = 'password'
            }
              }
    }
}
</script>
