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
                <li v-show="!editMode" class="breadcrumb-item"> {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item"> {{title}}</li>
            </ol>
        </nav>

<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="col-lg-8 offset-lg-2 from-wrapper">
                <form>
                    <div class="row">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Name <span class="text-red">*</span></label>
                                <input class="form-control" disabled type="text" v-model="form.name"/>
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
                                    <option  v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                                </select>
                            </div>
                            <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                        </div>

                        <div class="col-sm-6" v-if="$page.auth.user.user_type == 'admin' ">
                            <div class="form-group">
                                <label>Department<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.department_id" disabled>
                                     <option  v-for="dep in data.departments" :value="dep.id" :key="dep.id">{{dep.name}}</option>
                                </select>
                                <div class="text-danger" v-if="errors.department_id">{{ errors.department_id[0] }}</div>

                            </div>
                        </div>

                        <div class="col-sm-6" v-if="$page.auth.user.user_type == 'owner'">
                            <div class="form-group">
                                <label>Departmenssst<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.department_id" disabled>
                                    <option  v-for="dep in data.departments" :value="dep.id" :key="dep.id">{{dep.name}}</option>

                                </select>
                                <div class="text-danger" v-if="errors.department_id">{{ errors.department_id[0] }}</div>

                            </div>
                        </div>

                        <div class="col-sm-6"  v-show="editMode">
                            <div class="form-group">
                                <label>Role<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.role_id" disabled>
                                    <option  v-for="rol in data.roles" :value="rol.id" :key="rol.id">{{rol.name}}</option>
                                </select>
                                <div class="text-danger" v-if="errors.role_id">{{ errors.role_id[0] }}</div>

                            </div>
                        </div>
                    </div>
                    <div class="m-t-50 d-flex  justify-content-end">
                        <a v-show="editMode" :href="route('admin/reset', [this.data.id])" class="reset-pass" type="button">Reset Password</a>
                        <a v-show="editMode" :href="route('admin/password', [this.data.id])" class="save1" type="button">Change Password</a>
                        <a v-show="editMode" :href="route('staff/edit', [this.data.id])" class="reset-pass" type="button">Edit Memeber</a>
                    </div>

                    <!-- <div class="m-t-20   text-center">
                          <button
                            type="button"
                            class="save3"
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

                    </div> -->
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
        if (this.editMode) {
            this.form = this.data
            this.form.password = null
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
            this.editMode = true;
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
