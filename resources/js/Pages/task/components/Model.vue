<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2 v-if="editMode">{{ data.name }}</h2>
                    <h2 v-else>{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a v-if="editMode" :href="route('tasks.show',data.task_id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                        <a v-else :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> To Do</a>
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
                <li v-show="editMode" class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

        <div class="col-md-12">
            <form action="">
                <div class="col-md-12" style="padding: 0px;">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card-box">
                                <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 30px; padding-bottom: 6px;">
                                    <h4>Task Information</h4>
                                </div>
                                <div class="form-group">
                                    <label>Task Name<span class="text-red">*</span></label>
                                    <input class="form-control" type="text" v-model="form.name"/>
                                    <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                                </div>
                                <div class="form-group">
                                    <label for="des">Task Description<span class="text-red">*</span></label>
                                    <textarea id="des" cols="30" rows="8" class="form-control" v-model="form.instruction"></textarea>
                                    <div class="text-danger" v-if="errors.instruction">{{ errors.instruction[0] }}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="card-box">
                                <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 30px; padding-bottom: 6px;">
                                    <h4>Assignee Information</h4>
                                </div>
                                <div class="col-md-12" style="padding: 0px;">
                                    <div class="row">
                                        <div v-if="$page.auth.user.user_type == 'admin' " class="col-sm-12">
                                            <div class="col-sm-6" style="padding: 0px;">
                                                <div class="form-group">
                                                    <label>Organization<span class="text-red">*</span></label>
                                                    <Select2 style="width: 98% ;" @change="getData()" v-model="form.organization_id"
                                                             :options="organizations"
                                                    />
                                                </div>
                                                <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <input class="form-check-input all_check_margin" :checked="checkAll" :value="checkAll" type="checkbox" @click="checkDepartment"/>
                                                <label class="all_level_margin">Departments</label>
                                                <multiselect v-if="checkAll==true" v-model="form.departments"
                                                             tag-placeholder="Select department"
                                                             placeholder="Search department"
                                                             label="name"
                                                             track-by="id"
                                                             :options="departments"
                                                             :multiple="true"
                                                             :taggable="true"
                                                ></multiselect>
                                            </div>
                                        </div>

                                        <div class="col-sm-6" >
                                            <div class="form-group" >
                                                <input class="form-check-input all_check_margin" :checked="checkCat" :value="checkCat" type="checkbox" @click="checkCategory"/>
                                                <label class="all_level_margin">Categories</label>
                                                <multiselect v-if="checkCat==true" v-model="form.categories"
                                                             tag-placeholder="Select category"
                                                             placeholder="Search category"
                                                             label="name"
                                                             track-by="id"
                                                             :options="categories"
                                                             :multiple="true"
                                                             :taggable="true"
                                                ></multiselect>
                                            </div>
                                        </div>
                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <input class="form-check-input all_check_margin" :checked="checkType" :value="checkType" type="checkbox" @click="checkTypes"/>
                                                <label class="all_level_margin">Types</label>
                                                <multiselect  v-if="checkType==true" v-model="form.types"
                                                              tag-placeholder="Select type"
                                                              placeholder="Search type"
                                                              label="name"
                                                              track-by="id"
                                                              :options="types"
                                                              :multiple="true"
                                                              :taggable="true"
                                                ></multiselect>
                                            </div>
                                        </div>
                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <input class="form-check-input all_check_margin" :checked="checkUser" :value="checkUser" type="checkbox" @click="checkUsers"/>
                                                <label class="all_level_margin">Users</label>
                                                <multiselect v-if="checkUser==true" v-model="form.users"
                                                             tag-placeholder="Select User"
                                                             placeholder="Search User"
                                                             label="name"
                                                             track-by="id"
                                                             :options="users"
                                                             :multiple="true"
                                                             :taggable="true"

                                                ></multiselect>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Due Date <span class="text-red">*</span></label>
                                                <input class="form-control" type="datetime-local"  v-model="form.due_date"/>
                                                <div class="text-danger" v-if="errors.due_date">{{ errors.due_date[0] }}</div>
                                            </div>
                                        </div>

                                        <div v-if="editMode == 1" class="col-sm-12">
                                            <div class="col-sm-6" style="padding: 0px;">
                                                <div class="form-group">
                                                    <label>Task Status</label>
                                                    <select  style="width: 96%;" class="form-control select" :class="disability == 1 ? 'disabled':''" v-model="form.task_status">
                                                        <option value="OPEN" >OPEN</option>
                                                        <option value="CLOSE" >CLOSE</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>



                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-11">
                            <div class="m-t-20 text-center">
                                <button
                                    type="button"
                                    class="form-submit-btn ml-10 pull-right "
                                    wire:click.prevent="store()"
                                    @click="update(form)"
                                    v-show="editMode"
                                >
                                    Update
                                </button>

                                <button
                                    type="button"
                                    class="form-submit-btn ml-10 pull-right "
                                    wire:click.prevent="store()"
                                    @click="save(form)"
                                    v-show="!editMode"
                                >
                                    Save
                                </button>

                                <button
                                    style="background-color: #0DB314; width: auto;"
                                    type="button"
                                    class="form-submit-btn pull-right ml-10"
                                    wire:click.prevent="store()"
                                    @click="save_create(form)"
                                    v-show="!editMode"
                                >
                                    Save & Create Another
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>


    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import 'vue-datetime/dist/vue-datetime.css';
import moment from "moment";
import Select2 from "v-select2-component";
import Multiselect from "vue-multiselect";
import {HTTP} from "@/utils/http-common";

export default {
    components: {
        Alert,
        datetime: Datetime,
        Select2,
        Multiselect
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            moment:moment,
            checkAll:false,
            checkCat:false,
            checkType:false,
            checkUser:false,
            organizations:[{id: null, text: ''}],
            departments:[],
            users:[],
            categories:[],
            types:[],
            disability: 0,
            form: {
                departments:[],
                users:[],
                categories:[],
                types:[],
                index:'',
                id: undefined,
                name:null,
                instruction:null,
                due_date:null,
                organization_id:null
            }
        }
    },
    created () {
        if (this.editMode) {
            this.form = this.data
            this.form.due_date = moment(this.data.due_date).format("yyyy-MM-DDTHH:mm")
            this.form.departments = this.data.departments
            this.form.categories = this.data.categories
            this.form.types = this.data.types
            this.form.users = this.data.users

            if (this.data.user_type == 'admin'){
                HTTP.get('/organization/get-data/'+this.data.organization_id)
                    .then((response)=>{
                        this.departments = response.data.departments;
                        this.categories = response.data.categories;
                        this.types = response.data.types;
                        this.users = response.data.users;
                    })
            }

            if (this.data.departments.length != 0){
                this.checkAll = true
            }
            if (this.data.categories.length != 0){
                this.checkCat = true
            }
            if (this.data.types.length != 0){
                this.checkType = true
            }
            if (this.data.users.length != 0){
                this.checkUser = true
            }
            // disability
            if(this.data.task_status == 'CLOSE'){
                if(this.data.started_by_id == this.data.user_id){
                    this.disability = 0;
                }else {
                    this.disability = 1;
                }
            }
            if(this.data.task_status == 'OPEN'){
                if(this.data.started_by_id == null){
                    this.disability = 0;
                }else {
                    if(this.data.started_by_id == this.data.user_id){
                        this.disability = 0;
                    }else {
                        this.disability = 1;
                    }
                }
            }
        }
        //organizations
        if (this.data.user_type == 'admin'){
            let i = 0
            for(i=0; i<this.data.organizations.length; i++){
                this.organizations.push({
                    id: this.data.organizations[i].id,
                    text: this.data.organizations[i].name
                })
            }
        }

        // types,category,departments for user type != admin,,,
        if (this.data.user_type != 'admin'){
            HTTP.get('/organization/get-data/'+this.data.organization_id)
                .then((response)=>{
                    this.departments = response.data.departments;
                    this.categories = response.data.categories;
                    this.types = response.data.types;
                    this.users = response.data.users;
                })
        }
    },
    methods: {
        getData: function () {
            HTTP.get('/organization/get-data/'+this.form.organization_id)
                .then((response)=>{
                    this.departments = response.data.departments;
                    this.categories = response.data.categories;
                    this.types = response.data.types;
                    this.users = response.data.users;
                })
        },
        checkDepartment(){
            if(this.checkAll === false) {
                this.checkAll = true
            }else {
                this.checkAll = false
            }
        },
        checkCategory(){
            if(this.checkCat === false) {
                this.checkCat = true
            }else {
                this.checkCat = false
                // this.form.category_id = null
            }
        },
        checkTypes(){
            if(this.checkType === false) {
                this.checkType = true
            }else {
                this.checkType = false
                // this.form.type_id = null
            }
        },
        checkUsers(){
            if(this.checkUser === false) {
                this.checkUser = true
            }else {
                this.checkUser = false
                // this.form.user_id = null
            }
        },
        reset: function () {
            this.form = {}
        },
        save_create: function (params) {
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

            let users = [];
            params.users.forEach(function(data) {
                users.push(data['id'])
            });


            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;
            params['user_ids'] = users;

            params['task_type'] = 'MANUAL';
            params['task_reference_type'] = 'General';

            if (this.checkAll == false){
                params['department_ids']= null
            }
            if (this.checkCat == false){
                params['category_ids']= null
            }
            if (this.checkType == false){
                params['type_ids']= null
            }
            if (this.checkUser == false){
                params['user_ids']= null
            }
             this.$inertia.post('/tasks', params)

            // Uncheck Input Field
            if (this.checkAll == true){
                this.checkAll = false
            }
            if (this.checkCat == true){
                this.checkCat = false
            }
            if (this.checkType == true){
                this.checkType = false
            }
            if (this.checkUser == true){
                this.checkUser = false
            }

            // Reset Input Field
            if (this.data.user_type == 'admin'){
                this.departments = [];
                this.users = [];
                this.categories = [];
                this.types = [];
            }

            this.form = {
                departments:[],
                users:[],
                categories:[],
                types:[],
                index:'',
                name:null,
                instruction:null,
                due_date:null,
            }
        },
        save: function (params) {
            this.form.index = 'index'

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

            let users = [];
            params.users.forEach(function(data) {
                users.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;
            params['user_ids'] = users;

            params['task_type'] = 'MANUAL';
            params['task_reference_type'] = 'General';

            if (this.checkAll == false){
                params['department_ids']= null
            }
            if (this.checkCat == false){
                params['category_ids']= null
            }
            if (this.checkType == false){
                params['type_ids']= null
            }
            if (this.checkUser == false){
                params['user_ids']= null
            }

            this.$inertia.post('/tasks', params)
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

            let users = [];
            params.users.forEach(function(data) {
                users.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;
            params['user_ids'] = users;


            if (this.checkAll == false){
                params['department_ids']= null
            }
            if (this.checkCat == false){
                params['category_ids']= null
            }
            if (this.checkType == false){
                params['type_ids']= null
            }
            if (this.checkUser == false){
                params['user_ids']= null
            }

            params['_method']= 'PUT'

            this.$inertia.post('/tasks/' + params.id, params)
        }

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
