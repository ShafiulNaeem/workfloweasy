<template>
    <app-layout>

<!--        content start-->
        <div class="page-wrapper">
            <slot name="header"></slot>

            <div class="content">
                <div class="row">
                    <!--  Top Content start-->
                        <div class="dashboard-user-header col-12">
                        <div class="title-inner col-12">
                            <h2>GET STARTED WITH EASY WORKFLOW</h2>
                        </div>
                        <div class="multiply-button d-flex">
                            <div class="button1">
                                <i class="fa fa-bars h-fa-bars" aria-hidden="true"></i>
                                <h4>1. New Form</h4>
                            </div>
                            <div class="button1">
                                <i class="fa fa-users green" aria-hidden="true"></i>
                                <h4>2. New User</h4>
                            </div>
                            <div class="button1">
                                <i class="fa fa-file-text-o red" aria-hidden="true"></i>
                                <h4>3. New Report</h4>
                            </div>
                            <div class="button1">
                                <i class="fa fa-user" aria-hidden="true"></i>
                                <h4>4. New DashBoard</h4>
                            </div>
                            <div class="button1">
                                <i class="fa fa-sliders yellow" aria-hidden="true"></i>
                                <h4>5. New Assignment</h4>
                            </div>

                        </div>
                    </div>
                    <!-- Top Content end-->


                    <!-- Table Content start-->
                    <div class="latter col-12">
                        <vue-tabs active-tab-color="#3abfa7"
                                  active-text-color="white"
                                  border="1px solid #5944ec"

                        >
                            <v-tab title="Task" icon="ti-notepad">
                                <div class="container-para">
                                    <div class="para1 all">
                                        <table style="margin-left: 0px !important;" class="table table-striped table-fn-size">
                                            <thead>
                                            <tr class="bg-white">
                                                <th>#</th>
                                                <th>Form Categories</th>
                                                <th>Form Title</th>
                                                <th>Response Date</th>
                                                <th>Form Status</th>
                                                <th class="text-right">Action</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr v-for="(row,index) in data['data'].data" :key="row.id">
                                                <td>{{ index+1 }}</td>
                                                <td> <span class="badge badge-success" v-for="d in row.form.categories">{{d.name}} </span> </td>
                                                <td>{{ row.form.Form_title}}</td>
                                                <td>{{ row.response_date}}</td>

                                                <td><button class="custom-badge" v-bind:class="row.is_approved ? 'btn rd' : 'btn grn'">{{ row.is_approved ? "Close": "Open" }}</button></td>

                                                <td class="text-right">
                                                    <a href="#"  data-toggle="modal"  data-target="#clientDiscount" class="btn btn-yellow" @click="setActiveResponse(row)">Set Status</a>
                                                    <a :href="route('editData', [row.id])+'?from=task'" class="btn btn-color">Edit</a>
                                                    <a :href="route('viewData', [row.id])" class="btn btn-data-danger">View</a>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
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

                            </v-tab>

                            <v-tab title="Inbox" icon="ti-calendar">
                                Inbox content
                            </v-tab>

                            <v-tab title="Calendar" icon="ti-calendar">
                                Calendar content
                            </v-tab>

                            <v-tab title="Report" icon="ti-email">
                                <div class="container-para">
                                    <div class="para1 all">
                                        <table style="margin-left: 0px !important;" class="table table-striped table-fn-size">
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
                                            </tbody>
                                        </table>
                                        <div class="container-fluid d-flex">
                                            <nav aria-label="Page navigation example mr-auto">
                                                <ul class="pagination  pagi-color">
                                                    <li >
                                                        <a  href="#" tabindex="-1">Showing</a>
                                                    </li>
                                                    <li ><a  href="#">1 to</a></li>
                                                    <li ><a  href="#">5 of</a></li>
                                                    <li >
                                                        <a  href="#">entries</a>
                                                    </li>
                                                </ul>
                                            </nav>
                                            <nav aria-label="Page navigation example pagi-relation">
                                                <ul class="pagination ft">
                                                    <li class="page-item p-i"><a  href="#">Previous</a></li>
                                                    <li class="page-item pg"><a href="#">1</a></li>
                                                    <li class="page-item p-i"><a  href="#">Next</a></li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </v-tab>
                        </vue-tabs>

                        <!-- Modal start -->
                        <div class="modal fade" id="clientDiscount" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h5 class="modal-title pull-left" id="exampleModalLongTitle">Update Assignment</b></h5>

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
                        <!-- Modal end -->


                    </div>
                    <!-- Table Content end-->


                </div>
            </div>
            <div class="notification-box">
                <div class="msg-sidebar notifications msg-noti">
                    <div class="topnav-dropdown-header">
                        <span>Messages</span>
                    </div>
                    <div class="drop-scroll msg-list-scroll" id="msg_list">
                        <ul class="list-box">
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">R</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Richard Miles </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item new-message">
                                        <div class="list-left">
                                            <span class="avatar">J</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">John Doe</span>
                                            <span class="message-time">1 Aug</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">T</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Tarah Shropshire </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">M</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Mike Litorus</span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">C</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Catherine Manseau </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">D</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Domenic Houston </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">B</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Buster Wigton </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">R</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Rolland Webber </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">C</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author"> Claire Mapes </span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">M</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Melita Faucher</span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">J</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Jeffery Lalor</span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">L</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Loren Gatlin</span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="chat.html">
                                    <div class="list-item">
                                        <div class="list-left">
                                            <span class="avatar">T</span>
                                        </div>
                                        <div class="list-body">
                                            <span class="message-author">Tarah Shropshire</span>
                                            <span class="message-time">12:28 AM</span>
                                            <div class="clearfix"></div>
                                            <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="topnav-dropdown-footer">
                        <a href="chat.html">See all messages</a>
                    </div>
                </div>
            </div>
        </div>
<!--        content start-->

        <welcome />

    </app-layout>
</template>

<script>
    //import Vue from 'vue';
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import {VueTabs, VTab} from 'vue-nav-tabs'
    import 'vue-nav-tabs/themes/vue-tabs.css'
    export default {
        components: {
            AppLayout,
            Welcome,
            VueTabs,
            VTab,

        },
        props:['data'],
        data(){
            return{
                activeResponse: {},
                taskData:[]
            }
        },

        methods:{
            // getTasks(){
            //     axios.get('/taskDashboard').then(response => {
            //         this.taskData = response.data;
            //         console.log(this.taskData);
            //     });
            // },
            setActiveResponse: function (data) {
                this.activeResponse = data
            },
            updateStatus: function () {
                this.$inertia.post('/form/response/changeStatus', this.activeResponse)
            },
        },
        mounted() {
            //this.getTasks();
        }
    }
</script>
