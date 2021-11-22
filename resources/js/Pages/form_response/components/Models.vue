<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ data.form.Form_title }} Data</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> {{ title }}</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <!--         Content start-->
        <div class="container-fluid form-user-wrapper">
            <div class="row">
                <div class="breadcrumb-wrapper col-12 ">
                    <nav aria-label="Page breadcrumb">
                        <ul class="breadcrumb ml">
                            <li class="breadcrumb-item" aria-current="page">Main</li>
                            <li class="breadcrumb-item">{{label}}</li>
                            <li class="breadcrumb-item">{{title}}</li>
                            <li class="breadcrumb-item">{{ data.form.Form_title }}</li>
                        </ul>
                    </nav>
                </div>

                <div class="col-md-12">
                    <div class="table-responsive">
                        <form action="">
                            <div class="col-sm-12 date_root">
                                <label class="date_export bold" for="" >Export: </label>

                                <button style="float: right;" @click="getDateData()" class="btn btn-data my-2 my-sm-0 mr-4 ml-3" type="button" >Go</button>

                                <div class="date_sub" style="">
                                    <input name="to_date" v-model="dateQuery.to_date" class="select_style" type="date" id="example-date-input">
                                </div>
                                <label class="date_lavel" for="example-date-input" >To </label>

                                <div class="date_sub" >
                                    <input nmae="from_date" v-model="dateQuery.from_date" class="select_style" type="date">
                                </div>
                                <label class="date_lavel"  for="" >From </label>
                            </div>
                        </form>
                        <table class="table table-border table-striped custom-table datatable mb-0">
                            <thead>
                            <tr class="bg-white">
                                <th> # </th>
                                <th v-for="(value, index) in data.field_title" v-if="value.field_type != 'heading' && value.field_type != 'infobox'">
                                    {{value.field_label}}
                                </th>
                                <th>Submission Date </th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody class="exception">
                            <tr  v-for="(row, index) in data['response'].data">
                                <td>{{ index+1 }}</td>
<!--                                <td v-for="(val, index) in orderData(row.response,data.field_title)">-->
<!--                                    <a  target="_blank" v-if="val.fields.field_type == 'fileupload'" :href="val.response_value">View File</a>-->
<!--                                    <span v-else>{{ val.response_value }}</span>-->
<!--                                </td>-->
                                <td v-for="(val, index) in orderData(data.field_title,row.response)" v-if="val.field_type != 'heading' && val.field_type != 'infobox'">
                                    <a  target="_blank" v-if="val.field_type == 'fileupload'" :href="val.response_value">View File</a>
                                    <span v-else>{{ val.response_value }}</span>
                                </td>
                                <td>{{ row.response_date }}</td>

                                <td class="text-right">
                                    <div class="dropdown dropdown-action ">
                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>
                                        <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">
                                            <button @click="setActiveResponse(row.id)" class="dropdown-item"  data-toggle="modal" data-target="#updateStatus"><i class="fa fa-plus m-r-5"></i> Create Task</button>
                                            <a class="dropdown-item" :href="route('submissionData', [row.id])"><i class="fa fa-pencil m-r-5"></i> View</a>
                                            <button  @click="deleteRow(row)" class="dropdown-item"  data-toggle="modal" data-target="#delete_patient"><i class="fa fa-trash-o m-r-5"></i> Delete</button>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

<!--                Pagination start-->
                <div class="container-fluid d-flex">
                    <nav aria-label="Page navigation example mr-auto">
                        <ul class="pagination  pagi-color">
                            <li >
                                <a  href="#" tabindex="-1">Showing</a>
                            </li>
                            <li ><a  href="#">{{ data['response'].to }} to</a></li>
                            <li ><a  href="#">{{ data['response'].total }} of</a></li>
                            <li >
                                <a  href="#">entries</a>
                            </li>
                        </ul>
                    </nav>
                    <nav aria-label="Page navigation example pagi-relation">
                        <ul class="pagination ft">
                            <li class="page-item"  v-for="row in data['response'].links" :key="row.label"  v-bind:class="row.active ? ' pg' : 'p-i'">
                                <a :href="row.url"><span v-html="row.label"></span></a>
                            </li>
                        </ul>
                    </nav>
                </div>
<!--                {{data.responses_field[0].get_responses_form_field.get_response_field[0].response[0]}}-->
<!--                Pagination end-->

                <!-- Modal start -->
                <div class="modal fade" id="updateStatus" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content" style="background-color: #179f7b;">
                            <div class="modal-header">

                                <h5 class="modal-title pull-left" id="exampleModalLongTitle"><b style="color: snow;">Create Task</b></h5>

                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span style="color: currentColor;" aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <form action="">
                                            <div class="col-md-12" style="padding: 0px;">
                                                <div class="row">
                                                    <div class="col-md-6">
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
                                                    <div class="col-md-6">
                                                        <div class="card-box">
                                                            <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 30px; padding-bottom: 6px;">
                                                                <h4>Assignee Information</h4>
                                                            </div>
                                                            <div class="col-md-12" style="padding: 0px;">

                                                                <div  v-if="$page.auth.user.user_type == 'admin' " class="form-group">
                                                                    <label>Organization<span class="text-red">*</span></label>
                                                                    <Select2 class="select2" style="width: 100%;" @change="getOrgData()" v-model="form.organization_id"
                                                                             :options="organizations"
                                                                    />
                                                                    <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label>Due Date <span class="text-red">*</span></label>
                                                                    <input class="form-control" type="datetime-local"  v-model="form.due_date"/>
                                                                    <div class="text-danger" v-if="errors.due_date">{{ errors.due_date[0] }}</div>
                                                                </div>

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
                                                                @click="save(form)"
                                                            >
                                                                Save
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Modal end -->

            </div>
        </div>
        <!--         Content end-->

        <slot name="header"></slot>
    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink';
import Alert from '@/Pages/Component/Alert';
import {Datetime} from "vue-datetime";
import Select2 from "v-select2-component";
import Multiselect from "vue-multiselect";
import {HTTP} from "@/utils/http-common";

 export default {
    components: {
        JetResponsiveNavLink,
        Alert,
        datetime: Datetime,
        Select2,
        Multiselect
    },
    props: ['data','title','flash','errors','link','label'],
     data() {
         return {
             filter_types: [
                 {'key_value': '', 'key_name': 'All'},
                 {'key_value': 'id', 'key_name': 'ID'},
             ],
             form_fields_id:null,
             query: {
                 search_type: '',
                 search_text: ''
             },
             dateQuery:{
                 from_date: '',
                 to_date: '',
             },

             //task create property start
             checkAll:false,
             checkCat:false,
             checkType:false,
             checkUser:false,
             organizations:[{id: null, text: ''}],
             departments:[],
             users:[],
             categories:[],
             types:[],
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
             },
             task_reference_id:null,
             //task create property end
         }
     },
     mounted() {
         if (!_.isEmpty(this.data.query)) {
             this.query = this.data.query
         }
         if (!_.isEmpty(this.data.query)) {
             this.dateQuery = this.data.query
         }

     },
     //task create property start
     created () {
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
        getOrgData: function () {
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
        setActiveResponse: function (data) {
             this.task_reference_id = data
             // console.log( this.task_reference_id)
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

             let users = [];
             params.users.forEach(function(data) {
                 users.push(data['id'])
             });


             params['department_ids'] = departments;
             params['category_ids'] = categories;
             params['type_ids'] = types;
             params['user_ids'] = users;

             params['task_type'] = 'AUTOMATED';
             params['task_reference_type'] = 'Form Response';
             params['task_reference_id'] = this.task_reference_id;

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
        //task create property end

         orderData: function (field_title,response_value) {
             let field =_.orderBy(field_title, 'id')
             let response = _.orderBy(response_value, 'id')

             let response_field = []
             response.forEach(function(data) {
                 response_field[data.form_field_id] = data.response_value
             });

             field.forEach(function(data) {
                 data['response_value'] = response_field[data.id]
             });

             return field
         },

        // orderData: function (data,title) {
        //     let obj = _.orderBy(data, 'id')
        //
        //     if(obj.length !== title.length){
        //         let diff = title.length - obj.length;
        //
        //         for (let i = 0; i < diff; i++) {
        //             obj.push({
        //                 id: null,
        //                 form_id: null,
        //                 response_value: "",
        //                 fields: {
        //                     field_type: "text",
        //                 },
        //             })
        //         }
        //
        //     }
        //     return obj
        // },
        resetQuery: function () {
            this.query = null
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/form/response', this.query)
        },
        getData: function () {
            this.$inertia.get('/form/response', this.query)
        },
        getDateData: function () {
            console.log(this.data.form_id)
            this.$inertia.get('/forms/response/'+ this.data.form.id, this.dateQuery)
        },
        deleteRow: function (data) {
             if (!confirm('Are you sure want to remove?')) return;
             data._method = 'DELETE';
             this.$inertia.post('/form/response/' + data.id, data)
         }

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
