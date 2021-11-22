<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!--         Navbar top start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <form class="form-inline"  id="filter-form">
                            <div class="form-group">
                                <select class="select_style form-control select" v-model="query.search_type" >
                                    <option  v-for="row in filter_types" :key="row.key_value" :value="row.key_value">{{ row.key_name }}</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input class="form-control mr-sm-2"  v-model="query.search_text"  :type="query.search_type == 'due_date'?'date':'search'" placeholder="Enter Your Text" aria-label="Search">
                            </div>

                            <button @click="getData()"  class="btn btn-outline-success my-2 my-sm-0 mr-4 ml-3" type="button">Search</button>
                        </form>
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-plus"></i> Task</a>
                    </nav>

                </div>
            </div>
        </div>
        <!--         Navbar top end-->

        <!--         Content start-->
        <div class="container-fluid form-user-wrapper">
            <div class="row">
                <div class="breadcrumb-wrapper col-12 ">
                    <nav aria-label="Page breadcrumb">
                        <ul class="breadcrumb ml">
                            <li class="breadcrumb-item" aria-current="page">Main</li>
                            <li class="breadcrumb-item">{{label}}</li>
                            <li class="breadcrumb-item">{{title}}</li>
                        </ul>
                    </nav>
                </div>

                <div class="col-md-12">
                    <div class="table-responsive">
<!--                        <form action="">-->
<!--                            <div class="col-sm-12 date_root">-->
<!--                                <label class="date_export bold" for="" >Export: </label>-->

<!--                                <button style="float: right;" @click="getDateData()" class="btn btn-data my-2 my-sm-0 mr-4 ml-3" type="button" >Go</button>-->

<!--                                <div class="date_sub" style="">-->
<!--                                    <input name="to_date" v-model="dateQuery.to_date" class="select_style" type="date" id="example-date-input">-->
<!--                                </div>-->
<!--                                <label class="date_lavel" for="example-date-input" >To </label>-->

<!--                                <div class="date_sub" >-->
<!--                                    <input nmae="from_date" v-model="dateQuery.from_date" class="select_style" type="date">-->
<!--                                </div>-->
<!--                                <label class="date_lavel"  for="" >From </label>-->
<!--                            </div>-->
<!--                        </form>-->

<!--                        temporary remove datatable-->
                        <table  style="margin-top: 15px;" class="table table-border table-striped custom-table mb-0">
                            <thead>
                            <tr class="bg-white">
                                <th>#</th>
                                <th>Task Name </th>
                                <th>Instruction </th>
                                <th>Assign To </th>
                                <th>Due Date </th>
                                <th>Group </th>
                                <th>Created by</th>
                                <th>Task Status </th>
                                <th>Assignment Status </th>
                                <th>Started By </th>
                                <th class="text-right">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="(row,index) in data['data'].data" :key="row.id">
                                <td>{{ index+1 }}</td>
                                <td>{{ row.taskdetails ? row.taskdetails.name : null }}</td>
                                <td>{{ row.taskdetails ? row.taskdetails.instruction : null }}</td>
                                <td>
                                    <span v-if="row.taskdetails != null" class="badge" :class="row.task_type == 'MANUAL' ?'badge-primary':'badge-success'" v-for="d in row.get_taskdetails.departments">{{d.name}} </span>
                                    <span v-else class="badge badge-success" >Not Assign</span>
                                </td>

                                <td>{{ moment(row.due_date).format("DD-MM-YYYY hh:mm a")}}</td>
                                <td>{{ row.task_reference_type? row.task_reference_type:'' }}</td>
                                <td>{{ row.created_by_name? row.created_by_name.name:'' }}</td>
                                <td><button class="custom-badge" v-bind:class="row.task_status == 'OPEN' ? 'btn grn' : 'btn rd'">{{ row.task_status }}</button></td>
                                <td>
                                    <span v-if="row.status == 'PENDING'" class="badge badge-danger" >{{ row.status }}</span>
                                    <span v-if="row.status == 'ACCEPTED'" class="badge badge-primary" >{{ row.status }}</span>
                                    <span v-if="row.status == 'COMPLETED'" class="badge badge-success" >{{ row.status }}</span>
                                </td>
                                <td>{{ row.started_by ? row.started_by.name : null }}</td>
                                 <td class="text-right">
                                        <div class="dropdown dropdown-action ">
                                            <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">
                                                <button v-if="row.status == 'PENDING'"  @click="startNow(row.id)" class="dropdown-item" ><i class="fa fa-pencil m-r-5"></i> Start Now</button>
                                                <button v-if="row.started_by_id == $page.auth.user.id"  @click="setActiveResponse(row)" class="dropdown-item"  data-toggle="modal" data-target="#updateStatus"><i class="fa fa-edit m-r-5"></i> Change Status</button>
                                                <!--  task_type for MANUAL-->
                                                <a class="dropdown-item" :href="route('tasks.show', [row.id])"><i class="fa fa-edit m-r-5"></i> View</a>
                                                <button @click="deleteRow(row)" class="dropdown-item"  data-toggle="modal" data-target="#delete_patient"><i class="fa fa-trash-o m-r-5"></i> Delete</button>
                                            </div>
                                        </div>
                                 </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!--                Pagination Start-->
                <div style="margin-top: 10px;" class="container-fluid d-flex">
                    <nav aria-label="Page navigation example mr-auto">
                        <ul class="pagination  pagi-color">
                            <li >
                                <a  href="#" tabindex="-1">Showing</a>
                            </li>
                            <li ><a  href="#">{{ data['data'].to }} to</a></li>
                            <li ><a  href="#">{{ data['data'].total }} of</a></li>
                            <li >
                                <a  href="#">entries</a>
                            </li>
                        </ul>
                    </nav>
                    <nav aria-label="Page navigation example pagi-relation">
                        <ul class="pagination ft">
                            <li class="page-item"  v-for="row in data['data'].links" :key="row.label"  v-bind:class="row.active ? ' pg' : 'p-i'">
                                <a :href="row.url"><span v-html="row.label"></span></a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <!--                Pagination end-->
            </div>
        </div>


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
                                                    class="btn btn-primary submit-btn cls"
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
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'
import moment from 'moment'

 export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['data','title','flash','errors','link','label'],
     data() {
         return {
             moment: moment,
             filter_types: [
                 {'key_value': '', 'key_name': 'All'},
                 {'key_value': 'name', 'key_name': 'Task Name'},
                 {'key_value': 'group', 'key_name': 'Group'},
                 {'key_value': 'status', 'key_name': 'Assignment Status'},
                 {'key_value': 'task_status', 'key_name': 'Task Status'},
                 {'key_value': 'created_by', 'key_name': 'Created By'},
                 {'key_value': 'started_by', 'key_name': 'Started By'},
                 {'key_value': 'department', 'key_name': 'Assign To'},
                 {'key_value': 'due_date', 'key_name': 'Due Date'},
             ],
             query: {
                 search_type: '',
                 search_text: ''
             },
             dateQuery:{
                 from_date: '',
                 to_date: '',
             },
             activeResponse: {},
         }
     },
     mounted() {
         console.log(this.data);
         if (!_.isEmpty(this.data.query)) {
             this.query = this.data.query
         }
         if (!_.isEmpty(this.data.query)) {
             this.dateQuery = this.data.query
         }
     },
    methods: {

        resetQuery: function () {
            this.query = null
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/tasks', this.query)
        },
        getData: function () {
            this.$inertia.get('/tasks', this.query)
        },
        getDateData: function () {
            this.$inertia.get('/tasks', this.dateQuery)
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/tasks/' + data.id, data)
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

    }
}
</script>
