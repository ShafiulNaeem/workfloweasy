<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2 >{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Report Automation</a>
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
            </ol>
        </nav>

        <div class="col-md-12">
            <form action="">
                <div class="col-md-12" style="padding: 0px;">
                    <div class="row">
                        <div class="col-md-11">
                            <div class="card-box">
                                <div class="report-title" style="border-bottom: 1px solid #d8d8da; margin-bottom: 26px; padding-bottom: 6px;">
                                    <h4>Report Automation Information</h4>
                                </div>

                                <div class="row">

                                    <div class="col-md-6">
                                        <div class="form-group" style="margin-bottom: 48px;">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" :value="false" v-model="checkAll" name="flexRadioDefault" id="flexRadioDefault1">
                                                <label class="form-check-label" for="flexRadioDefault1">
                                                    Create Automation From Scratch
                                                </label>
                                            </div>

                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" :value="true" v-model="checkAll" name="flexRadioDefault" id="flexRadioDefault2">
                                                <label class="form-check-label" for="flexRadioDefault2">
                                                    Create Automation Using Report
                                                </label>
                                            </div>
                                        </div>
<!--                                        v-if="$page.auth.user.user_type == 'admin'"-->
                                        <div class="form-group" v-if="checkAll == true && $page.auth.user.user_type == 'admin'" style="margin-bottom: 0px;">
                                            <label>Organization</label>
                                            <Select2 style="width: 98% ;" @change="getReport()" v-model="form.organization_id"
                                                     :options="organizations"
                                            />
                                            <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                                        </div>

                                        <div class="form-group" v-if="checkAll == true">
                                            <label>Report<span class="text-red">*</span></label>
                                            <Select2 style="width: 98% ;" v-model="form.report_id"
                                                     :options="reports"
                                            />
                                            <div class="text-danger" v-if="error_report_id == 1">The Report field is required.</div>
                                        </div>

                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Report Generation Interval(Hours) <span class="text-red">*</span></label>
                                            <input class="form-control" type="number"  v-model="form.interval"/>
                                            <div class="text-danger" v-if="error_interval == 1">The interval field is required.</div>
                                        </div>

<!--                                        <div class="form-group">-->
<!--                                            <label>Report Duration (Days) <span class="text-red">*</span></label>-->
<!--                                            <input class="form-control" type="number"  v-model="form.duration"/>-->
<!--                                            <div class="text-danger" v-if="error_duration == 1">The interval field is required.</div>-->
<!--                                        </div>-->

                                        <div class="form-group">
                                            <label>Start Date (Date and Time) <span class="text-red">*</span></label>
                                            <input class="form-control" type="datetime-local"  v-model="form.last_running_time"/>
                                            <div class="text-danger" v-if="error_last_running_time == 1">The Start Date field is required.</div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-11">
                            <div class="text-center">
                                <button
                                    type="button"
                                    class="form-submit-btn ml-10 pull-right "
                                    wire:click.prevent="store()"
                                    @click="save(form)"
                                    v-show="!editMode"
                                >Next
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
import Alert from '@/Pages/Component/Alert';
import {Datetime} from "vue-datetime";
import Select2 from "v-select2-component";
import Multiselect from "vue-multiselect";
import moment from "moment";
import {HTTP} from "@/utils/http-common";

export default {
    name: "Automation",
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
            error_report_id:0,
            error_interval:0,
            error_duration:0,
            error_last_running_time:0,
            error_organization_id:0,
            report_slug:null,
            checkAll:false,
            organizations:[{id: null, text: ''}],
            reports:[{id: null, text: ''}],
            form: {
                id: undefined,
                report_id:null,
                interval:null,
                // duration:null,
                last_running_time:null,
                organization_id:null
            }
        }
    },
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

        //Report
        if (this.data.user_type != 'admin'){
            let reports = [];
            // this.reports = [];
            HTTP.get('/report-automation/get-report/' + this.data.organization_id)
                .then((response) => {
                    reports = response.data.reports;

                    let r = 0;
                    for(r = 0; r < reports.length; r++){
                        this.reports.push({
                            id: reports[r].id,
                            text: reports[r].report_name
                        })
                    }
                })
        }
    },
    methods: {
        getReport: function () {
            let reports = [];
            this.reports = [];
            this.form.report_id = null;

            HTTP.get('/report-automation/get-report/' + this.form.organization_id)
                .then((response) => {
                    reports = response.data.reports;

                    let r = 0;
                    for(r = 0; r < reports.length; r++){
                        this.reports.push({
                            id: reports[r].id,
                            text: reports[r].report_name
                        })
                    }
                })

        },
        // getReportSlug: function () {
        //     HTTP.get('/report-automation/get-report-slug/' + this.form.report_id)
        //         .then((response) => {
        //             this.report_slug = response.data.slug;
        //         })
        // },
        save: function (params) {
            params['is_for_automation'] = 'YES';

            let error_field = 0
            this.error_report_id = 0
            this.error_interval = 0
            // this.error_duration = 0
            this.error_last_running_time = 0
            this.error_organization_id = 0

            if (params['interval'] == null || params['interval'] == ''){
                this.error_interval = 1
            }
            // if (params['duration'] == null || params['duration'] == ''){
            //     this.error_duration = 1
            // }
            if (params['last_running_time'] == null || params['last_running_time'] == ''){
                this.error_last_running_time = 1
            }
            if (this.checkAll == true ){
                if (params['report_id'] == null || params['report_id'] == ''){
                    this.error_report_id = 1
                }
            }

            if (this.checkAll == false && this.error_interval == 0 && this.error_last_running_time == 0){
                params['report_id']= null
                // this.$inertia.get('/reports/generate', params)

                window.open('/reports/generate?interval='+ params['interval'] +'&last_running_time='+ params['last_running_time'] +'&is_for_automation=YES' , '_blank')
                params['interval'] = ''
                // params['duration'] = ''
                params['last_running_time'] = ''
            }
            if (this.checkAll == true && this.error_interval == 0 && this.error_last_running_time == 0 && this.error_report_id == 0){
                // this.$inertia.post('/report-automation/generate', params)

                window.open('/report-automation/generate?interval='+ params['interval'] +'&last_running_time='+ params['last_running_time'] +'&report_id='+ params['report_id'] +'&is_for_automation=YES' , '_blank')
                params['interval'] = ''
                // params['duration'] = ''
                params['last_running_time'] = ''
                params['organization_id'] = ''

                if (this.data.user_type == 'admin'){
                    params['report_id'] = ''
                    this.reports = [];
                }else {
                    params['report_id'] = ''
                }

            }

        },
    }
}
</script>

<style scoped>

</style>
