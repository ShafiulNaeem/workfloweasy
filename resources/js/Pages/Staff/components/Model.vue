<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Members</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-show="!editMode" class="breadcrumb-item">Users</li>
                <li v-show="!editMode" class="breadcrumb-item"> {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item"> {{title}}</li>
            </ol>
        </nav>

<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Create Member</h4>
            </div>
            <div class="col-lg-12 col-md-12  from-wrapper">
                <form>
                    <div class="row">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Name <span class="text-red">*</span></label>
                                <input class="form-control" type="text" v-model="form.name"/>
                                <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Email<span class="text-red">*</span></label>
                                <input class="form-control" type="email" v-model="form.email"/>
                                <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>Old Password</label>
                                <input class="form-control" type="password" v-model="form.old_password"/>
                                <div class="text-danger" v-if="errors.old_password">{{ errors.old_password[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>New Password</label>
                                <input class="form-control" type="password" v-model="form.password"/>
                                <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" v-show="editMode">
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input class="form-control" type="password" v-model="form.confirm_password"/>
                            </div>
                        </div>



                        <div class="col-sm-6" v-show="!editMode">
                            <div class="form-group">
                                <label> Password<span class="text-red">*</span></label>
                                <input class="form-control" :type="type" v-model="form.password"/>
                                <span @click="showPassword"
                                      :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>
                            </div>
                        </div>
                        <div class="col-sm-6" v-show="!editMode">
                            <div class="form-group">
                                <label>Confirm Password<span class="text-red">*</span></label>
                                <input class="form-control" :type="con_type" v-model="form.confirm_password"/>
                                <span @click="showConfirmPassword"
                                      :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                                      class="field-icon toggle-password"
                                ></span>
                                <div class="text-danger" v-if="errors.confirm_password">{{ errors.confirm_password[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Phone<span class="text-red">*</span></label>
                                <input class="form-control"  type="text" v-model="form.phone"/>
                                <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                            </div>
                        </div>

                        <div v-if="$page.auth.user.user_type == 'admin' " class="col-sm-6">
                            <div class="form-group">
                                <label>Organization<span class="text-red">*</span></label>
                                 <Select2 @change="getData()" v-model="form.organization_id"
                                         :options="myOptions"
                                />
                            </div>
                            <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Department<span class="text-red">*</span></label>
                                <multiselect v-model="form.departments"
                                             tag-placeholder="Select department"
                                             placeholder="Search department"
                                             label="name"
                                             track-by="id"
                                             :options="departments"
                                             :multiple="true"
                                             :taggable="true"

                                ></multiselect>
                                 <div class="text-danger" v-if="errors.department_ids">{{ errors.department_ids[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Categories<span class="text-red">*</span></label>
                                <multiselect v-model="form.categories"
                                             tag-placeholder="Select category"
                                             placeholder="Search category"
                                             label="name"
                                             track-by="id"
                                             :options="categories"
                                             :multiple="true"
                                             :taggable="true"

                                ></multiselect>
                                 <div class="text-danger" v-if="errors.category_ids">{{ errors.category_ids[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Types<span class="text-red">*</span></label>
                                <multiselect v-model="form.types"
                                             tag-placeholder="Select type"
                                             placeholder="Search type"
                                             label="name"
                                             track-by="id"
                                             :options="types"
                                             :multiple="true"
                                             :taggable="true"

                                ></multiselect>
                                  <div class="text-danger" v-if="errors.type_ids">{{ errors.type_ids[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Role<span class="text-red">*</span></label>
                                <Select2 v-model="form.role_id"
                                         :options="myRoles"
                                />
                                <div class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</div>

                            </div>
                        </div>
                    </div>

                    <div class="m-t-20   text-center">
                          <button style="right:13%"
                            type="button"
                            class="save_create"
                            wire:click.prevent="store()"
                            v-show="!editMode"
                            @click="saveAndAnother(form)"
                        >
                            Create & Another User
                        </button>
                        <button
                            type="button"
                            class="save"
                            wire:click.prevent="store()"
                            v-show="!editMode"
                            @click="save(form)"
                        >
                            Save
                        </button>

                        <button
                            type="button"
                            class="save_role"
                            wire:click.prevent="store()"
                            v-show="editMode"
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
import Alert from '@/Pages/Component/Alert';
import { Datetime } from 'vue-datetime';
import moment from "moment";
import {HTTP} from '@/utils/http-common';
import Multiselect from 'vue-multiselect';
import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        datetime: Datetime,
        Multiselect,
        Select2
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            myOptions:[{id: null, text: ''}],
            myRoles:[{id: null, text: ''}],
            photo: null,
            departments:[],
            categories:[],
            types:[],
            form: {
                departments:[],
                categories:[],
                types:[],
                id: undefined,
                name: null,
                phone: null,
                email: null,
                password:null,
                organization_id:null,
                role_id: null,
            },
            type:'password',
            con_type:'password'

        }
    },

    created () {

        this.departments = this.data.departments
        this.categories = this.data.categories
        this.organizations = this.data.organizations
        this.types = this.data.types
        if (this.editMode) {
            this.form = this.data

            // let i = 0
            // for(i=0; i<this.data.department_id.length; i++){
            //     this.department.push({
            //         id: this.data.department_id[i].id,
            //         name: this.data.department_name[i].name
            //     })
            // }
        }
        let i = 0
        for(i=0; i<this.data.organizations.length; i++){
            this.myOptions.push({
                id: this.data.organizations[i].id,
                text: this.data.organizations[i].name
            })
        }
          let j = 0
            for(j=0; j<this.data.roles.length; j++){
                this.myRoles.push({
                    id: this.data.roles[j].id,
                    text: this.data.roles[j].name
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
        addService: function (){

        },
        getData: function () {
          HTTP.get('/organization/get-data/'+this.form.organization_id)
              .then((response)=>{
                  this.departments = response.data.departments;
                  this.categories = response.data.categories;
                  this.types = response.data.types;

              })
      },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        reset: function () {
            this.form = {}
        },
        save: function (params) {

            let departments = [];
            params.departments.forEach(function(data) {
                departments.push(data['id'])
            });


            let categories = [];
            params.categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            params.types.forEach(function(data) {
                types.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;

            this.$inertia.post('/staffs', params)
        },
        saveAndAnother: function (params) {
            let departments = [];
            params.departments.forEach(function(data) {
                departments.push(data['id'])
            });

            let categories = [];
            params.categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            params.types.forEach(function(data) {
                types.push(data['id'])
            });

            // var data = new FormData()
            this.form.saveAndAnother = 1

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;

            this.$inertia.post('/staffs', params)
            this.form = {
                departments:[],
                categories:[],
                types:[],
                id: undefined,
                name: null,
                phone: null,
                email: null,
                password:null,
                organization_id:null,
                role_id: null,
            }

            if (this.data.user_type !== 'owner'){
                this.departments=[]
                this.categories=[]
                this.types=[]
            }


        },
        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.editMode = true;
            this.openModal();
        },
        update: function (params) {

            let departments = [];
            params.departments.forEach(function(data) {
                departments.push(data['id'])
            });

            let categories = [];
            params.categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            params.types.forEach(function(data) {
                types.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;

            this.$inertia.post('/staffs/' + params.id, params)
        }
    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
