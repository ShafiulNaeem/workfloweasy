<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ form.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> To Do</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item"> {{title}}</li>
                <li class="breadcrumb-item"> {{form.name}}</li>
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
                                    <label>Task Name</label>
                                    <input class="form-control disabled" type="text" v-model="form.name"/>
                                </div>
                                <div class="form-group">
                                    <label for="des">Task Description</label>
                                    <textarea id="des" cols="30" rows="7" class="form-control disabled" v-model="form.instruction"></textarea>
                                </div>

                                <div v-show="this.data.task_reference_type != 'General'" class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 20px; margin-Top: 40px; padding-bottom: 6px;">
                                    <h4>Assignment Information</h4>
                                </div>

                                <div v-show="this.data.task_reference_type != 'General'" class="form-group">
                                    <table style="border: none !important;" class="table table-borderless">
                                        <tbody>
                                            <tr style="height: 30px !important;" v-show="this.data.task_reference_type == 'Form Submission'">
                                                <th style="padding: 0px !important; width: 90px;" scope="row">Form Name</th>
                                                <td  style="padding: 0px !important;">:
                                                    <a style="text-decoration-line: underline;" :href="route('forms.response', [data.formResponse?data.formResponse.form.slug:''])" target="_blank">{{data.formResponse?data.formResponse.form.Form_title:''}}</a>
                                                </td>
                                            </tr>
                                            <tr style="height: 30px !important;" v-show="this.data.task_reference_type == 'Form Submission' || this.data.task_reference_type == 'Form Response'">
                                                <th style="padding: 0px !important; width: 90px;" scope="row">Form Data</th>
                                                <td  style="padding: 0px !important;">:
                                                    <a style="text-decoration-line: underline;" :href="route('submissionData', [data.task_reference_id])" target="_blank">View Data</a>
                                                </td>
                                            </tr>
                                            <tr style="height: 30px !important;" v-show="this.data.task_reference_type == 'Form'">
                                                <th style="padding: 0px !important; width: 90px;" scope="row">Form Name</th>
                                                <td  style="padding: 0px !important;">:
                                                    <a style="text-decoration-line: underline;" :href="route('forms.response', [data.form?data.form.slug:''])" target="_blank">{{data.form?data.form.Form_title:''}}</a>
                                                </td>
                                            </tr>
                                            <tr style="height: 30px !important;" v-show="this.data.task_reference_type == 'Report'">
                                                <th style="padding: 0px !important; width: 90px;" scope="row">Report Name</th>
                                                <td  style="padding: 0px !important;">:
                                                    <a style="text-decoration-line: underline;" :href="route('reports.preview', [data.report?data.report.slug:''])" target="_blank">{{data.report?data.report.report_name:''}}</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

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
                                                    <label>Organization</label>
                                                    <select class="form-control select disabled" v-model="form.organization_id">
                                                        <option v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <label>Departments</label>
                                                <multiselect  v-model="form.departments"
                                                             tag-placeholder="Select department"
                                                             placeholder="Not Assign"
                                                             label="name"
                                                             track-by="id"
                                                             :options="departments"
                                                             :multiple="true"
                                                             :taggable="true"
                                                             disabled="disabled"
                                                ></multiselect>
                                            </div>
                                        </div>

                                        <div class="col-sm-6" >
                                            <div class="form-group" >
                                                <label>Categories</label>
                                                <multiselect v-model="form.categories"
                                                             tag-placeholder="Select category"
                                                             placeholder="Not Assign"
                                                             label="name"
                                                             track-by="id"
                                                             :options="categories"
                                                             :multiple="true"
                                                             :taggable="true"
                                                             disabled="disabled"
                                                ></multiselect>
                                            </div>
                                        </div>
                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <label>Types</label>
                                                <multiselect  v-model="form.types"
                                                              tag-placeholder="Select type"
                                                              placeholder="Not Assign"
                                                              label="name"
                                                              track-by="id"
                                                              :options="types"
                                                              :multiple="true"
                                                              :taggable="true"
                                                              disabled="disabled"
                                                ></multiselect>
                                            </div>
                                        </div>
                                        <div class="col-sm-6" >
                                            <div class="form-group">
                                                <label>Users</label>
                                                <multiselect v-model="form.users"
                                                             tag-placeholder="Select User"
                                                             placeholder="Not Assign"
                                                             label="name"
                                                             track-by="id"
                                                             :options="users"
                                                             :multiple="true"
                                                             :taggable="true"
                                                             @tag="addService"
                                                             disabled="disabled"
                                                ></multiselect>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label>Due Date</label>
                                                <input class="form-control disabled" type="datetime-local"  v-model="form.due_date"/>
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="col-sm-6" style="padding: 0px;">
                                                <div class="form-group">
                                                    <label>Task Status</label>
                                                    <select  style="width: 96%;" class="form-control select disabled" v-model="data.task_status">
                                                        <option :value="data.task_status" >{{data.task_status}}</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
<!--                            <div class="text-center" v-show="this.data.task_reference_type == 'Form Submission'">-->
<!--                                <a style="margin-top: 63px;" :href="route('submissionData', [data.task_reference_id])" target="_blank" class="btn btn-primary view_cls pull-right"> View Data</a>-->
<!--                            </div>-->

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-11">
                            <div class="m-t-20 text-center">
                                <button
                                    type="button"
                                    class="form-submit-btn ml-10 pull-right "
                                    wire:click.prevent="store()"
                                    @click="Edit()"
                                >
                                    Edit
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

import Alert from "@/Pages/Component/Alert";
import {Datetime} from "vue-datetime";
import Select2 from "v-select2-component";
import Multiselect from "vue-multiselect";
import moment from "moment";

export default {
    name: "Modelview",
    components: {
        Alert,
        datetime: Datetime,
        Select2,
        Multiselect
    },

    props: ['data','viewMode', 'link', 'title', 'label'],
    data () {
        return {
            moment:moment,
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
                organization_id:null,

            }
        }
    },
    created () {

        if (this.viewMode) {
            this.form = this.data.taskDetails
            this.form.due_date = moment(this.data.taskDetails.due_date).format("yyyy-MM-DDTHH:mm")

            this.form.departments = this.data.taskDetails.departments
            this.form.categories = this.data.taskDetails.categories
            this.form.types = this.data.taskDetails.types
            this.form.users = this.data.taskDetails.users

            this.departments = this.data.all_departments;
            this.categories = this.data.all_categories;
            this.types = this.data.all_types;
            this.users = this.data.all_users;

        }

    },
    methods: {
        Edit(){
            this.$inertia.get('/tasks/' + this.data.id +'/edit')
        },
        viewData(){
            this.$inertia.get('/form/response/' + this.data.task_reference_id + '/submission-data')
        },
    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>

<style scoped>

</style>
