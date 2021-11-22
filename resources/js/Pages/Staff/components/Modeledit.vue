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
                        <a  :href="route('staffs.show',data.id)" class="btn btn-primary text-white btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item">Users</li>
                <li class="breadcrumb-item"> {{title}}</li>
                <li class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Member Update</h4>
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

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Phone<span class="text-red">*</span></label>
                                <input class="form-control" type="text" v-model="form.phone"/>
                                <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                            </div>
                        </div>

                        <div v-if="$page.auth.user.user_type == 'admin' " class="col-sm-6">
                            <div class="form-group">
                                <label>Organization<span class="text-red">*</span></label>
                                 <Select2 @change="getDepartments()" v-model="form.organization_id"
                                         :options="myOptions"
                                />
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
                                ></multiselect>

                            </div>
                        </div>

<!--                        <div class="col-sm-6" >-->
<!--                            <div class="form-group">-->
<!--                                <label>Role<span class="text-red">*</span></label>-->
<!--                                <Select2 v-model="form.role_id"-->
<!--                                             :options="myRole"-->
<!--                                    />-->
<!--                            </div>-->
<!--                        </div>-->

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Status<span class="text-red">*</span></label>
                                 <Select2 v-model="form.status"
                                         :options="statusOption"
                                />
                                <div class="text-danger" v-if="errors.status">{{ errors.status[0] }}</div>
                            </div>
                        </div>
                    </div>
                    <div class="m-t-20 text-center">
                        <!-- <a  :href="route('member.update', [this.data.id])" class="save" type="button">Update</a>
                         <button
                            type="button"
                            class="save"
                            v-show="editMode"
                            wire:click.prevent="store()"
                            @click="update(form)"
                        >
                            Update
                        </button> -->
                         <button
                            type="button"
                            class="save"
                            wire:click.prevent="store()"
                            @click="update(form)"
                        >
                            update
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
            statusOption:[
                {id:1, text: 'Active'},
                {id:2, text: 'Inactive'},
            ],
            myOptions:[{id: null, text: ''}],
            photo: null,
            myRole:[{id: null, text: ''}],
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
                status : null,
                saveAndAnother:null
            }
        }
    },
    created () {
        console.log(this.form.organization_id)
        if (this.editMode) {
            this.form = this.data
             this.form.organization_id = this.data.organization_id
            this.departments = this.data.all_departments;
            this.categories = this.data.all_categories;
            this.types = this.data.all_types;
            this.status = this.data.status;
            this.form.password = null;
            // this.organizations = this.data.organizations

            this.selected_departments = this.data.departments;
            this.selected_categories = this.data.categories;
            this.selected_types = this.data.types;

            let i = 0
            for(i=0; i<this.data.organizations.length; i++){
                this.myOptions.push({
                    id: this.data.organizations[i].id,
                    text: this.data.organizations[i].name
                })
            }
         }

    },
    methods: {
      goBack: function() {
        window.history.back();
        },
      getDepartments: function () {
          HTTP.get('/organization/get-data/'+this.form.organization_id)
              .then((response)=>{
                  this.departments = response.data.departments;
                  this.categories = response.data.categories;
                  this.types = response.data.types;
              })
      },
        addService: function () {
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

            let departments = [];

            this.selected_departments.forEach(function(data) {
                departments.push(data['id'])

            });
            let categories = [];
            this.selected_categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            this.selected_types.forEach(function(data) {
                types.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;

            params['_method'] = 'PUT';
            this.$inertia.put('/staffs/' + params.id, params)
        }
    }
}
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
