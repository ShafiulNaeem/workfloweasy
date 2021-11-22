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
                <li  class="breadcrumb-item">Users</li>
                <li class="breadcrumb-item"> {{title}}</li>
                <li class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Member Information</h4>
            </div>
            <div class="col-lg-12 col-md-12  from-wrapper">
                <form>
                    <div class="row">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Name <span class="text-red">*</span></label>
                                <input class="form-control" type="text" disabled v-model="form.name"/>
                                <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Email<span class="text-red">*</span></label>
                                <input class="form-control" disabled type="email" v-model="form.email"/>
                                <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                            </div>
                        </div>


                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Phone<span class="text-red">*</span></label>
                                <input class="form-control" disabled type="text" v-model="form.phone"/>
                                <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                            </div>
                        </div>

                        <div v-if="$page.auth.user.user_type == 'admin' " class="col-sm-6">
                            <div class="form-group">
                                <label>Organization<span class="text-red">*</span></label>
                                <select class="form-control select" @change="getDepartments()" disabled v-model="form.organization_id">
                                    <option v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                                </select>
                            </div>
                            <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                        </div>


                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Department<span class="text-red">*</span></label>
                                <multiselect v-model="selected_departments"
                                             tag-placeholder="Select department"
                                             placeholder="Search department"
                                             label="name"
                                             track-by="id"
                                             :options="departments"
                                             :multiple="true"
                                             :taggable="true"
                                             @tag="addService"
                                             disabled="disabled"
                                ></multiselect>
                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Categories<span class="text-red">*</span></label>
                                <multiselect v-model="selected_categories"
                                             tag-placeholder="Select category"
                                             placeholder="Search category"
                                             label="name"
                                             track-by="id"
                                             :options="categories"
                                             :multiple="true"
                                             :taggable="true"
                                             @tag="addService"
                                             disabled="disabled"
                                ></multiselect>

                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Types<span class="text-red">*</span></label>
                                <multiselect v-model="selected_types"
                                             tag-placeholder="Select type"
                                             placeholder="Search type"
                                             label="name"
                                             track-by="id"
                                             :options="types"
                                             :multiple="true"
                                             :taggable="true"
                                             @tag="addService"
                                             disabled="disabled"
                                ></multiselect>

                            </div>
                        </div>



                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Role<span class="text-red">*</span></label>
                                <select class="form-control select" disabled v-model="form.role_id">
                                    <option v-for="rol in data.roles" :value="rol.id" :key="rol.id">{{rol.name}}</option>
                                </select>
                                <div class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</div>

                            </div>
                        </div>
                    </div>
                    <div class="m-t-20 text-center">
                        <a  :href="route('member.edit', [this.data.id])" class="save" type="button">Edit</a>
                        <a  :href="route('member.password.reset', [this.data.id])" class="reset-pass1" type="button">Reset Password</a>
                        <a  :href="route('member.password', [this.data.id])" class="save_create" type="button" style="right:13%">Edit Password</a>
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
import Multiselect from 'vue-multiselect'

export default {
    components: {
        Alert,
        datetime: Datetime,
        Multiselect
    },
    props: ['data', 'errors', 'viewMode', 'link', 'title', 'label'],
    data () {
        return {
            photo: null,
            departments:[],
            categories:[],
            types:[],
            selected_departments:[],
            selected_categories:[],
            selected_types:[],
            form: {
                id: undefined,
                name: null,
                phone: null,
                email: null,
                password:null,
                department_id: null,
                organization_id: null,
                role_id: null,
                saveAndAnother:null
            }
        }
    },
    created () {
        if (this.viewMode) {
            this.form = this.data
            this.departments = this.data.all_departments;
            this.categories = this.data.all_categories;
            this.types = this.data.all_types;
            this.form.password = null;

            this.selected_departments = this.data.departments;
            this.selected_categories = this.data.categories;
            this.selected_types = this.data.types;

        }
    },
    methods: {
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
        save: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('organization_id', params.organization_id || '')
            data.append('department_id', params.department_id || '')
            data.append('role_id', params.role_id || '')
            data.append('user_id', params.user_id || '')

            this.$inertia.post('/staffs', data)
        },
        saveAndAnother: function (params) {
            var data = new FormData()
            this.form.saveAndAnother = 1
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('organization_id', params.organization_id || '')
            data.append('department_id', params.department_id || '')
            data.append('saveAndAnother', params.saveAndAnother || '')
            data.append('role_id', params.role_id || '')
            data.append('user_id', params.user_id || '')

            this.$inertia.post('/staffs', data)
            this.form = {}
        },
        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.viewMode = true;
            this.openModal();
        },
        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('old_password', params.old_password || '')
            data.append('confirm__password', params.confirm_password || '')
            data.append('organization_id', params.organization_id || '')
            data.append('department_id', params.department_id || '')
            data.append('user_id', params.user_id || '')
            data.append('_method', 'PUT')

            this.$inertia.post('/staffs/' + params.id, data)
        }
    }
}
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
