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
<!--                        <form class="form-inline">-->
<!--                            <div class="form-group">-->
<!--                                <select class="select_style form-control select" v-model="query.search_type" >-->
<!--                                    <option  v-for="row in filter_types" :key="row.key_value" :value="row.key_value">{{ row.key_name }}</option>-->
<!--                                </select>-->
<!--                            </div>-->
<!--                            <div class="form-group">-->
<!--                                <input class="form-control mr-sm-2" v-model="query.search_text" type="search" placeholder="name" aria-label="Search">-->
<!--                            </div>-->

<!--                            <button @click="getData()"  class="btn btn-outline-success my-2 my-sm-0 mr-4 ml-3" type="button">Search</button>-->
<!--                        </form>-->
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
                            <li class="breadcrumb-item">{{ title }}</li>
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
                                <th>#</th>
                                <th>Form Category</th>
                                <th>Form Title</th>
                                <th>Response Date</th>
                                <th>Form Status</th>
                                <th class="text-right">Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="(row,index) in data['data'].data" :key="row.id">
                                <td>{{ index+1 }}</td>
                                <td>{{ row.form.category.name}}</td>
                                <td>{{ row.form.Form_title}}</td>
                                <td>{{ row.response_date}}</td>

                                <td><button class="custom-badge" v-bind:class="row.is_approved ? 'btn grn' : 'btn rd'">{{ row.is_approved ? "Close": "Open" }}</button></td>

                                <td class="text-right">
                                    <a href="#"  data-toggle="modal"  data-target="#clientDiscount" class="btn btn-yellow" @click="setActiveResponse(row)">Set Status</a>
                                    <a :href="route('editData', [row.id])+'?from=task'" class="btn btn-color">Edit</a>
                                    <a :href="route('viewData', [row.id])" class="btn btn-data-danger">View</a>
                                    <!--                                <jet-responsive-nav-link href="#" active="" class="btn btn-sm btn-success text-white">-->
                                    <!--                                    <i class="fa fa-pencil m-r-5"></i>Edit-->
                                    <!--                                </jet-responsive-nav-link>-->
                                </td>
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


        <!-- Modal -->
        <div class="modal fade" id="clientDiscount" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">

                        <h5 class="modal-title pull-left" id="exampleModalLongTitle">Update form status</b></h5>

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
                                                <label> Form Status</label><br/>
                                                <div class="form-check form-check-inline">
                                                    <input
                                                        v-model="activeResponse.is_approved"
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="status"
                                                        value="1"
                                                    />
                                                    <label
                                                        class="form-check-label"
                                                        for="product_active"
                                                    >
                                                        Close
                                                    </label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input
                                                        v-model="activeResponse.is_approved"
                                                        class="form-check-input"
                                                        type="radio"
                                                        name="status"
                                                        value="0"
                                                    />
                                                    <label
                                                        class="form-check-label"
                                                        for="product_inactive"
                                                    >
                                                        Open
                                                    </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="m-t-20 text-center">
                                                <button
                                                    type="button"
                                                    class="btn btn-primary submit-btn"
                                                    wire:click.prevent="store()"
                                                    @click="updateStatus()"
                                                >
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

    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'

export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['data','title','flash','errors','link','label'],
    data() {
        return {
            activeResponse: {},
            filter_types: [
                {'key_value': '', 'key_name': 'All'},
                {'key_value': 'name', 'key_name': 'Title'},
            ],
            query: {
                search_type: '',
                search_text: ''
            },
            dateQuery:{
                from_date: '',
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
        setActiveResponse: function (data) {
            this.activeResponse = data
        },
        updateStatus: function () {
            this.$inertia.post('/form/response/changeStatus', this.activeResponse)
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/tasks/pending-tasks', this.query)
        },
        getData: function () {
            this.$inertia.get('/tasks/pending-tasks', this.query)

        },
        getDateData: function () {
            this.$inertia.get('/tasks/pending-tasks', this.dateQuery)
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/tasks/' + data.id, data)
        }
    }
}
</script>
