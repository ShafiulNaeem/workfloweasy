<template>
    <div class="page-wrapper user-color" style="padding-bottom: 20px;">
        <!-- Navbar top Start-->
        <slot name="header"></slot>
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2  >{{data.report_name}}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Report Automation</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item"> {{label}} </li>
                <li class="breadcrumb-item"> {{title}}</li>
                <li class="breadcrumb-item"> {{form.report_name}}</li>
            </ol>
        </nav>

        <div class="col-md-12">
            <form action="">
                <div class="col-md-11 " style="padding: 0px;">
                    <div class="row">
                        <div class="col-md-6 ">
                            <div class="card-box">
                                <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 20px; padding-bottom: 6px;">
                                    <h4>Last Generated Report</h4>
                                </div>
                                <div class="form-group">
                                    <label for="name">Report Automation Name</label>
                                    <input type="text" disabled class="form-control" id="name" v-model="form.report_name">
                                </div>
                                <div class="form-group">
                                    <label>Generated at </label>
                                    <input disabled class="form-control" type="datetime-local"  v-model="form.created_at"/>
                                </div>
                                <div class="form-group">
                                    <label>Form Name</label>
                                    <select  style="width: 96%;" class="form-control select disabled" v-model="form.form_id">
                                        <option v-for=" get_form in data.all_forms" :value="get_form.id" :key="get_form.id">{{get_form.Form_title}}</option>
                                    </select>
                                </div>
                                <div class="row" v-if="data.date_range != null" v-for=" range in data.date_range" :key="range.id">
                                    <div class="form-group col-md-5">
                                        <label v-if="range.filter_type == 1">Date Range {{form.type == 'COMPARE'?'#1':''}}</label>
                                        <label v-if="range.filter_type == 2">Date Range #2</label>
                                        <input disabled class="form-control" type="date"  v-model="range.start_date"/>
                                    </div>
                                    <div class="form-group col-md-1" style="margin-top: 41px;">
                                        <label>To</label>
                                    </div>
                                    <div class="form-group col-md-5" style="margin-top: 31px;">
                                        <input disabled class="form-control" type="date"  v-model="range.end_date"/>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-6 card-box">
                            <div class="">
                                <!--                        <h6 class="my-2">Select Form</h6>-->
                                <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 20px; padding-bottom: 6px;">
                                    <h4>Next Generated Report</h4>
                                </div>
                                <div class="form-group">
                                    <label>Generate will be </label>
                                    <input disabled class="form-control" type="datetime-local"  v-model="form.next_report_generate_date"/>
                                </div>
                                <div class="form-group">
                                    <label>Form Name</label>
                                    <select  style="width: 96%;" class="form-control select disabled" v-model="form.form_id">
                                        <option v-for=" get_form in data.all_forms" :value="get_form.id" :key="get_form.id">{{get_form.Form_title}}</option>
                                    </select>
                                </div>
                                <div class="row" v-if="data.next_date_range != null" v-for=" range in data.next_date_range" :key="range.id">
                                    <div class="form-group col-md-5">
                                        <label v-if="range.filter_type == 1">Date Range {{form.type == 'COMPARE'?'#1':''}}</label>
                                        <label v-if="range.filter_type == 2">Date Range #2</label>
                                        <input disabled class="form-control" type="date"  v-model="range.start_date"/>
                                    </div>
                                    <div class="form-group col-md-1" style="margin-top: 41px;">
                                        <label>To</label>
                                    </div>
                                    <div class="form-group col-md-5" style="margin-top: 31px;">
                                        <input disabled class="form-control" type="date"  v-model="range.end_date"/>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class=" text-center">
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
        <!--            start task list fetch form automation  -->
        <div class="col-md-12">
            <div class="card-box" style="padding: 0px;">
                <div class="report-title" style="border-bottom: 1px solid #d8d8da; padding-left: 14px; padding-top: 18px;">
                    <h4>Report Automation History</h4>
                </div>
                <div class="col-md-12" style="padding: 16px;">
                    <div class="table-responsive">
                        <table class="table table-border table-striped custom-table mb-0">
                            <thead>
                            <tr class="bg-white">
                                <th>#</th>
<!--                                <th>Report Automation Name</th>-->
                                <th>Previous Running Time</th>
                                <th>Last Running Time</th>
                                <th>Report Name</th>
                                <th>Report Type</th>
                                <th>Generated at</th>
                                <th class="text-right">Action</th>
                            </tr>
                            </thead>
                                <tbody>
                                <tr   v-for="(row,index) in data['histories'].data" :key="row.id">
                                    <td>{{ index+1 }}</td>
<!--                                    <td>{{ row.reportAutomation }}</td>-->
                                    <td> {{ moment(row.previous_running_time).format("DD-MM-YYYY hh:mm a")}}</td>
                                    <td> {{ moment(row.last_running_time).format("DD-MM-YYYY hh:mm a")}}</td>
                                    <td>{{ row.report ? row.report.report_name : null }}</td>
                                    <td>
                                        <span v-if="row.report != null" :class="row.report.type == 'COMPARE'?'badge badge-success':'badge badge-primary'">{{row.report.type}} TABULAR</span>
                                    </td>
                                    <td> {{ moment(row.created_at).format("DD-MM-YYYY hh:mm a")}}</td>

                                    <td class="text-right">
                                        <div class="dropdown dropdown-action ">
                                            <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">
                                                <a v-if="row.report != null" target="_blank" class="dropdown-item" :href="route('reports.edit', [row.report.slug])"><i class="fa fa-pencil m-r-5"></i> View</a>
                                                <button  @click="deleteRow(row)" class="dropdown-item"  data-toggle="modal" data-target="#delete_patient"><i class="fa fa-trash-o m-r-5"></i> Delete</button>
                                            </div>
                                        </div>
                                    </td>

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
                    <li ><a  href="#">{{ data['histories'].to }} to</a></li>
                    <li ><a  href="#">{{ data['histories'].total }} of</a></li>
                    <li >
                        <a  href="#">entries</a>
                    </li>
                </ul>
            </nav>
            <nav aria-label="Page navigation example pagi-relation">
                <ul class="pagination ft" style="right: 14px !important;">
                    <li class="page-item"  v-for="row in data['histories'].links" :key="row.label"  v-bind:class="row.active ? ' pg' : 'p-i'">
                        <a :href="row.url"><span v-html="row.label"></span></a>
                    </li>
                </ul>
            </nav>
        </div>
        <!--                Pagination end-->

        <div class="col-md-12">
<!--            <div class="col-md-12">-->
<!--                <div class="row">-->
<!--                    <div class="col-md-5 card-box">-->
<!--                        <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 20px; padding-bottom: 6px;">-->
<!--                            <h4>Last Generated Report</h4>-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <label for="name">Report Automation Name</label>-->
<!--                            <input type="text" disabled class="form-control" id="name" v-model="form.report_name">-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <label>Generated at </label>-->
<!--                            <input disabled class="form-control" type="datetime-local"  v-model="form.created_at"/>-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <label>Form Name</label>-->
<!--                            <select  style="width: 96%;" class="form-control select disabled" v-model="form.form_id">-->
<!--                                <option v-for=" get_form in data.all_forms" :value="get_form.id" :key="get_form.id">{{get_form.Form_title}}</option>-->
<!--                            </select>-->
<!--                        </div>-->
<!--                        <div class="row" v-if="data.date_range != null" v-for=" range in data.date_range" :key="range.id">-->
<!--                            <div class="form-group col-md-5">-->
<!--                                <label v-if="range.filter_type == 1">Date Range {{form.type == 'COMPARE'?'#1':''}}</label>-->
<!--                                <label v-if="range.filter_type == 2">Date Range #2</label>-->
<!--                                <input disabled class="form-control" type="datetime-local"  v-model="range.start_date"/>-->
<!--                            </div>-->
<!--                            <div class="form-group col-md-1" style="margin-top: 41px;">-->
<!--                                <label>To</label>-->
<!--                            </div>-->
<!--                            <div class="form-group col-md-5" style="margin-top: 31px;">-->
<!--                                <input disabled class="form-control" type="datetime-local"  v-model="range.end_date"/>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                        &lt;!&ndash;                            <div class="form-group">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label for="des">Report Description<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <textarea id="des" disabled cols="30" rows="10" class="form-control" v-model="form.description"></textarea>&ndash;&gt;-->

<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Organization<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <select  style="width: 96%;" class="form-control select disabled" v-model="form.organization_id">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <option v-for=" org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </select>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <div class="form-group ">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Categories<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <multiselect v-model="selected_categories"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             tag-placeholder="Select form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             placeholder="Search form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             label="name"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             track-by="id"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :options="categories"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :multiple="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :taggable="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             disabled="disabled"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                >&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </multiselect>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <div class="text-danger" v-if="errors.category_ids">The Categories field is required.</div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <div class="form-group ">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Departments<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <multiselect v-model="selected_departments"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             tag-placeholder="Select form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             placeholder="Search form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             label="name"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             track-by="id"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :options="departments"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :multiple="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :taggable="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             disabled="disabled"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                >&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </multiselect>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <div class="text-danger" v-if="errors.department_ids">The Departments field is required.</div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <div class="form-group ">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Types<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <multiselect v-model="selected_types"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             tag-placeholder="Select form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             placeholder="Search form category"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             label="name"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             track-by="id"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :options="types"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :multiple="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             :taggable="true"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                             disabled="disabled"&ndash;&gt;-->
<!--                        &lt;!&ndash;                                >&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </multiselect>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <div class="text-danger" v-if="errors.type_ids">The Types field is required.</div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                    </div>-->
<!--                    <div class="col-md-5 ml-3 card-box">-->
<!--                        &lt;!&ndash;                        <h6 class="my-2">Select Form</h6>&ndash;&gt;-->
<!--                        <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 20px; padding-bottom: 6px;">-->
<!--                            <h4>Next Generated Report</h4>-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <label>Generate will be </label>-->
<!--                            <input disabled class="form-control" type="datetime-local"  v-model="form.next_report_generate_date"/>-->
<!--                        </div>-->
<!--                        <div class="form-group">-->
<!--                            <label>Form Name</label>-->
<!--                            <select  style="width: 96%;" class="form-control select disabled" v-model="form.form_id">-->
<!--                                <option v-for=" get_form in data.all_forms" :value="get_form.id" :key="get_form.id">{{get_form.Form_title}}</option>-->
<!--                            </select>-->
<!--                        </div>-->
<!--                        <div class="row" v-if="data.next_date_range != null" v-for=" range in data.next_date_range" :key="range.id">-->
<!--                            <div class="form-group col-md-5">-->
<!--                                <label v-if="range.filter_type == 1">Date Range {{form.type == 'COMPARE'?'#1':''}}</label>-->
<!--                                <label v-if="range.filter_type == 2">Date Range #2</label>-->
<!--                                <input disabled class="form-control" type="datetime-local"  v-model="range.start_date"/>-->
<!--                            </div>-->
<!--                            <div class="form-group col-md-1" style="margin-top: 41px;">-->
<!--                                <label>To</label>-->
<!--                            </div>-->
<!--                            <div class="form-group col-md-5" style="margin-top: 31px;">-->
<!--                                <input disabled class="form-control" type="datetime-local"  v-model="range.end_date"/>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                        &lt;!&ndash;                            <div class="row">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <div class="form-group col-md-6">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <label>Form Category<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <select  style="width: 96%;" class="form-control select disabled" v-model="form.category_id">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                        <option v-for=" cat in data.all_categories" :value="cat.id" :key="cat.id">{{cat.name}}</option>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    </select>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </div>&ndash;&gt;-->

<!--                        &lt;!&ndash;                                <div class="form-group col-md-6">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <label>Form Name<span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <select  style="width: 96%;" class="form-control select disabled" v-model="form.form_id">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                        <option v-for=" get_form in data.all_forms" :value="get_form.id" :key="get_form.id">{{get_form.Form_title}}</option>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    </select>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->

<!--                        &lt;!&ndash;                            <div class="form-group">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Report Type <span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <select  style="width: 96%;" class="form-control select disabled" v-model="form.type">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <option value="SINGLE">Single Tabular</option>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                    <option value="COMPARE">Compare Tabular</option>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                </select>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->

<!--                        &lt;!&ndash;                            <div class="form-group">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Report Generation Interval(Hours) <span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <input disabled class="form-control" type="number"  v-model="form.interval"/>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            <div class="form-group">&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <label>Start Date (Date and Time) <span class="text-red">*</span></label>&ndash;&gt;-->
<!--                        &lt;!&ndash;                                <input disabled class="form-control" type="datetime-local"  v-model="form.last_running_time"/>&ndash;&gt;-->
<!--                        &lt;!&ndash;                            </div>&ndash;&gt;-->

<!--                    </div>-->
<!--                </div>-->
<!--                <div class="col-md-10 mb-5" style="margin-top: -20px; margin-bottom: 50px;">-->
<!--                    <div class="m-t-10 text-center">-->
<!--                        <button-->
<!--                            type="button"-->
<!--                            class="form-submit-btn  pull-right  ml-10"-->
<!--                            wire:click.prevent="store()"-->
<!--                            @click="Edit()"-->
<!--                        >-->
<!--                            Edit-->
<!--                        </button>-->
<!--                    </div>-->
<!--                </div>-->

<!--            </div>-->
        </div>

    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert';
import { Datetime } from 'vue-datetime';
import {HTTP} from '@/utils/http-common'
import Multiselect from 'vue-multiselect';
import Select2 from 'v-select2-component';
import moment from "moment";

export default {
    name: "ViewAutomation",
    components: {
        Alert,
        datetime: Datetime,
        Multiselect,
        Select2,
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            moment:moment,
            myOptions:[{id: null, text: ''}],
            catsOptions:[{id: null, text: ''}],
            formsOptions:[{id: null, text: ''}],
            categories:[],
            departments:[],
            types:[],
            forms:[],
            selected_departments:[],
            selected_categories:[],
            selected_types:[],
            compare:false,
            form: {
                departments:[],
                categories:[],
                types:[],
                id: undefined,
                report_name: "",
                description: "",
                category_id:"",
                form_id:"",
                type:'SINGLE',
                organization_id:"",
            }
        }
    },

    created () {
            this.form = this.data;
            this.form.last_running_time = moment(this.data.last_running_time).format("yyyy-MM-DDTHH:mm");
            this.form.created_at = moment(this.data.created_at).format("yyyy-MM-DDTHH:mm");
            this.form.next_report_generate_date = moment(this.data.next_report_generate_date).format("yyyy-MM-DDTHH:mm");

            this.categories = this.data.all_categories;
            this.departments = this.data.all_departments;
            this.types = this.data.all_types;

            this.selected_departments = this.data.departments;
            this.selected_categories = this.data.categories;
            this.selected_types = this.data.types;

            //last_date_range
            if (this.data.date_range != null){
                this.data.date_range.forEach(function(range) {
                    range['start_date'] = moment(range['start_date']).format("yyyy-MM-DD");
                    range['end_date'] = moment(range['end_date']).format("yyyy-MM-DD");
                });
            }

            //next_date_range
            if (this.data.next_date_range != null){
                this.data.next_date_range.forEach(function(range) {
                    range['start_date'] = moment(range['start_date']).format("yyyy-MM-DD");
                    range['end_date'] = moment(range['end_date']).format("yyyy-MM-DD");

                });
            }


    },
    methods: {
        handleCompare: function(text, id){
            this.compare = text;
        },
        reset: function () {
            this.form = {}
        },
        Edit(){
            window.open('/reports/generate/' +this.data.slug , '_blank')
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/report-automation/delete_history/' + data.id, data)
        }

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>

<style scoped>

</style>
