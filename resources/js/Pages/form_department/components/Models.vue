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
                        <form class="form-inline" id="filter-form">
                            <div class="form-group">
                                <select class="select_style form-control select" v-model="query.search_type" >
                                    <option  v-for="row in filter_types" :key="row.key_value" :value="row.key_value">{{ row.key_name }}</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input class="form-control mr-sm-2"  v-model="query.search_text"  type="search" placeholder="Enter Your Text" aria-label="Search">
                            </div>

                            <button @click="getData()"  class="btn btn-outline-success my-2 my-sm-0 mr-4 ml-3" type="button">Search</button>
                        </form>
                        <a :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-plus"></i>{{label}}</a>
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
                        <form action="">
                            <div class="col-sm-12 date_root">
                                <label class="date_export bold" for="" >Export: </label>

                                <button style="float: right;" @click="getDateData()" class="btn btn-data my-2 my-sm-0 mr-4 ml-3" type="button" >Go</button>

                                <div class="date_sub" style="">
                                    <input name="to_date" v-model="dateQuery.to_date" class="select_style" type="date" id="example-date-input">
<!--                                    <date-picker v-model="dateQuery.to_date" valueType="format"></date-picker>-->
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
                                <th>#</th>
                                <th>Name</th>
                                <th v-if="$page.auth.user.user_type == 'admin'">Organization</th>
                                <th class="text-right">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="(row,index) in data['data'].data" :key="row.id">
                                <td>{{ index+1}}</td>
                                <td>{{ row.name}}</td>
                                <td v-if="$page.auth.user.user_type == 'admin'">{{ row.organization?row.organization.name : ' ' }}</td>

                                <td v-if="$page.auth.user.user_type == 'staff'" class="text-right">
                                    <a :class="$page.auth.user.id != row.created_by?'disabled':'' " :href="route('form-department.edit', [row.id])" class="btn btn-color">Edit</a>
                                    <a :class="$page.auth.user.id != row.created_by?'disabled':'' " href="#" class="btn btn-danger" @click="deleteRow(row)">Delete</a>
                                </td>
                                <td class="text-right">
                                        <div class="dropdown dropdown-action ">
                                            <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">
                                                <a class="dropdown-item" :href="route('form-department.edit', [row.id])"><i class="fa fa-pencil m-r-5"></i> Edit</a>
                                                <button  @click="deleteRow(row)" class="dropdown-item"  data-toggle="modal" data-target="#delete_patient"><i class="fa fa-trash-o m-r-5"></i> Delete</button>
                                            </div>
                                        </div>
                                 </td>

                                <!--                        <td class="text-right">-->
                                <!--                            <a :href="route('form-department.edit', [row.id])" class="btn color_button">Edit</a>-->
                                <!--                            <a href="#" class="btn danger_button" @click="deleteRow(row)">Delete</a>-->
                                <!--                        </td>-->
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!--                Pagination Start-->
                <div class="container-fluid d-flex">
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
        <!--         Content end-->

    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink';
import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';

 export default {
    components: {
        JetResponsiveNavLink,
        DatePicker
    },
    props: ['data','title','flash','errors','link','label'],
     data() {
         return {
             filter_types: [
                 {'key_value': '', 'key_name': 'All'},
                 {'key_value': 'name', 'key_name': 'Name'},
             ],
             query: {
                 search_type: '',
                 search_text: ''
             },
             dateQuery:{
                 from_date: '05-03-2021',
                 to_date: '',
             }
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
    methods: {
        resetQuery: function () {
            this.query = null
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/form-department', this.query)
        },
        getData: function () {
            this.$inertia.get('/form-department', this.query)
        },
        getDateData: function () {
            this.$inertia.get('/form-department', this.dateQuery)
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/form-department/' + data.id, data)
        }
    }
}
</script>
