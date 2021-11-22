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
                        <a :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Automation</a>
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
                <li class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <div class="register-title">
                <h4>Automation Information</h4>
            </div>
            <div class="col-md-12 from-wrapper">
                <form>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Name <span class="text-red">*</span></label>
                                <input class="form-control disabled" type="text" v-model="form.name"/>
                            </div>
                        </div>
                        <div class="col-sm-6">

                            <div class="form-group">
                                <label>Due Date(Hours) <span class="text-red">*</span></label>
                                <input class="form-control disabled" type="text" v-model="form.due_date"/>
                            </div>
                        </div>

                        <div v-if="$page.auth.user.user_type == 'admin' " class="col-sm-12">
                            <div class="col-sm-6" style="padding: 0px;">
                                <div class="form-group">
                                    <label>Organization<span class="text-red">*</span></label>
                                    <select class="form-control select disabled" v-model="form.organization_id">
                                        <option v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                                    </select>
                                </div>

                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label>Departments</label>
                                <multiselect v-model="form.departments"
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
                                <label >Types</label>
                                <multiselect v-model="form.types"
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
                                             disabled="disabled"
                                ></multiselect>
                            </div>
                        </div>

                        <div class="col-sm-6" >
                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">Instructions <span class="text-red">*</span></label>
                                <textarea v-model="form.instruction" class="form-control disabled" id="exampleFormControlTextarea1" rows="4"></textarea>
                            </div>
                        </div>

                    </div>

                    <div class="m-t-20 text-center">
                        <button
                            type="button" class="save"
                            @click="Edit"
                        >Edit</button>
                    </div>
                </form>

            </div>

        </div>

        <!--            start task list fetch form automation  -->
        <div class="col-md-12">
            <div class="card-box" style="padding: 0px;">
                <div class="report-title" style="border-bottom: 1px solid #d8d8da; padding-left: 14px; padding-top: 18px;">
                    <h4>Task History</h4>
                </div>
                <div class="col-md-12" style="padding: 16px;">
                    <div class="table-responsive">
                        <table class="table table-border table-striped custom-table mb-0">
                            <thead>
                            <tr class="bg-white">
                                <th>#</th>
                                <th>Task Name</th>
                                <th>Submission Date </th>
                                <th>Due Date </th>
                                <th>Created By </th>
                                <th>Task Status </th>
                                <th>Assignment Status </th>
                                <th>Started By </th>
                                <th class="text-right">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr   v-for="(row,index) in data['all_task'].data" :key="row.id">
                                <td>{{ index+1 }}</td>
                                <td>{{ row.taskdetails ? row.taskdetails.name : null }}</td>
                                <td> {{ moment(row.created_at).format("DD-MM-YYYY hh:mm a")}}</td>
                                <td> {{ moment(row.due_date).format("DD-MM-YYYY hh:mm a")}}</td>
                                <td>{{ row.created_by_name ? row.created_by_name.name : null }}</td>
                                <td>
                                    <button class="custom-badge" v-bind:class="row.task_status == 'OPEN' ? 'btn grn' : 'btn rd'">{{ row.task_status }}</button>
                                </td>
                                <td>
                                    <span v-if="row.status == 'PENDING'" class="badge badge-danger" >{{ row.status }}</span>
                                    <span v-if="row.status == 'ACCEPTED'" class="badge badge-primary" >{{ row.status }}</span>
                                    <span v-if="row.status == 'COMPLETED'" class="badge badge-success" >{{ row.status }}</span>
                                </td>
                                <td>{{ row.started_by ? row.started_by.name : null }}</td>
                                <td class="text-right"><a :href="route('tasks.show', [row.id])" target="_blank"><i class="fa fa-edit m-r-5"></i> View Task</a></td>
<!--                                <td class="text-right">-->
<!--                                    <div class="dropdown dropdown-action ">-->
<!--                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>-->
<!--                                        <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">-->
<!--                                            <button v-if="row.status == 'PENDING'"  @click="startNow(row.id)" class="dropdown-item" ><i class="fa fa-pencil m-r-5"></i> Start Now</button>-->
<!--                                            <button v-else  @click="setActiveResponse(row)" class="dropdown-item"  data-toggle="modal" data-target="#updateStatus"><i class="fa fa-edit m-r-5"></i> Change Status</button>-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </td>-->

                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
        <!--  End task list fetch form automation  -->

        <!--                Pagination Start-->
        <div class="container-fluid d-flex" style="margin-top: -18px;">
            <nav aria-label="Page navigation example mr-auto">
                <ul class="pagination pagi-color">
                    <li >
                        <a  href="#" tabindex="-1">Showing</a>
                    </li>
                    <li ><a  href="#">{{ data['all_task'].to }} to</a></li>
                    <li ><a  href="#">{{ data['all_task'].total }} of</a></li>
                    <li >
                        <a  href="#">entries</a>
                    </li>
                </ul>
            </nav>
            <nav aria-label="Page navigation example pagi-relation">
                <ul class="pagination ft" style="right: 14px !important;">
                    <li class="page-item"  v-for="row in data['all_task'].links" :key="row.label"  v-bind:class="row.active ? ' pg' : 'p-i'">
                        <a :href="row.url"><span v-html="row.label"></span></a>
                    </li>
                </ul>
            </nav>
        </div>
        <!--                Pagination end-->

        <!-- Modal start -->
        <div class="modal fade" id="updateStatus" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">

                        <h5 class="modal-title pull-left" id="exampleModalLongTitle"><b>Update Assignment</b></h5>

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">

                                <form>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label> Update Status</label><br/>
                                                <div class="form-check form-check-inline">
                                                    <input
                                                        v-model="activeResponse.task_status"
                                                        class="form-check-input" type="radio" name="status" value="CLOSE"/>
                                                    <label class="form-check-label" for="product_active">Close</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input
                                                        v-model="activeResponse.task_status"
                                                        class="form-check-input" type="radio" name="status" value="OPEN"/>
                                                    <label class="form-check-label" for="product_inactive">Open</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="m-t-20 text-center">
                                                <button
                                                    type="button"
                                                    class="btn btn-primary submit-btn"
                                                    wire:click.prevent="store()"
                                                    @click="updateStatus()">
                                                    Update Status
                                                </button>
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
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import Multiselect from 'vue-multiselect';
import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        datetime: Datetime,
        Select2,
        Multiselect
    },

    props: ['data','viewMode', 'link', 'title', 'label'],
    data () {
        return {
             moment: moment,
            departments:[],
            users:[],
            categories:[],
            types:[],
            activeResponse: {},
            dateQuery:{
                from_date: '',
                to_date: '',
            },
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
            this.form = this.data

            this.departments = this.data.all_departments;
            this.categories = this.data.all_categories;
            this.types = this.data.all_types;
            this.users = this.data.all_users;

            this.form.departments = this.data.departments
            this.form.categories = this.data.categories
            this.form.types = this.data.types
            this.form.users = this.data.users
        }

    },
    methods: {
        Edit(){
            this.$inertia.get('/formAutomation/' + this.data.id +'/edit')
        },
        startNow(id){
            this.$inertia.get('/tasks/startNow/' +id)
        },
        setActiveResponse: function (data) {
            this.activeResponse = data
        },
        updateStatus: function () {
            this.$inertia.post('/tasks/changeStatus', this.activeResponse)
        },
        getDateData: function () {
            console.log('date wise data')
            // this.$inertia.get('/tasks', this.dateQuery)
        },
    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
