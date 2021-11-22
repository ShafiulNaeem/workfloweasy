<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!--         Navbar top start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ data.form.Form_title }} Data</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href=" route('form.response.show',data.form_id)" class="btn btn-primary btn-sm cls rg-top-btn">
                            <i class="fa fa-angle-left"></i> Go Back
                        </a>
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
                        <ol class="breadcrumb padding-top">
                            <li class="breadcrumb-item" aria-current="page">Main</li>
                            <li class="breadcrumb-item">{{label}}</li>
                            <li  class="breadcrumb-item">{{title}}</li>
                            <li class="breadcrumb-item"> {{data.form.Form_title}}</li>

                        </ol>
                    </nav>
                </div>
                    <div class="col-md-5">
                        <div class="card">
                            <div class="register-title">
                                <h4>Submission Information</h4>
                            </div>
                            <div class="card-body">
                                <table  style="border: none !important;" class="table table-borderless">
                                    <tbody>
                                    <tr style="height: 30px !important;">
                                        <th style="padding: 0px !important;" scope="row">Form Name</th>
                                        <td  style="padding: 0px !important;">: {{data.form?data.form.Form_title : 'Anynomus'}}</td>
                                    </tr>
                                    <tr style="height: 30px !important;">
                                        <th style="padding: 0px !important;" scope="row">Submited By</th>
                                        <td  style="padding: 0px !important;">: {{data.response_by_name?data.response_by_name.name:'Anynomus'}}</td>
                                    </tr>
                                    <tr style="height: 30px !important;">
                                        <th style="padding: 0px !important;" scope="row">Submission Date</th>
                                        <td  style="padding: 0px !important;">: {{data.response_date}}</td>
                                    </tr>
                                    <tr style="height: 30px !important;" >
                                        <th style="padding: 0px !important;" scope="row">Last Edit</th>
                                        <td v-if="data.last_edit !=null"  style="padding: 0px !important;">: {{ moment(data.last_edit.updated_at).format("YYYY-MM-DD HH:MM")}}</td>
                                        <td v-else class="text-danger" style="padding: 0px !important;">: Edit History Not Found!</td>
                                    </tr>
                                    <tr style="height: 30px !important;">
                                        <th  style="padding: 0px !important;" scope="row">Edited By</th>
                                        <td v-if="data.last_edit !=null" style="padding: 0px !important;">: {{data.last_edit.user.name}}</td>
                                        <td v-else class="text-danger" style="padding: 0px !important;">: Edit History Not Found!</td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>

                            <div class="register-title">
                                <h4>Edit History</h4>
                            </div>
                            <table class="table table-borderless table-striped">
                                <thead>
                                <tr>
                                    <th  style="font-size: 12px !important; " scope="col">Submission Date</th>
                                    <th  style="font-size: 12px !important; " scope="col">Submited By</th>
                                    <th  style="font-size: 12px !important; " scope="col">Edited By</th>
                                    <th  style="font-size: 12px !important; " scope="col">Currently Active</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-if="data.edit_histories != null" v-for="(row,index) in data.edit_histories" :key="row.id">
                                    <td  style="font-size: 12px !important; ">{{row.form_response?row.form_response.response_date:''}}</td>
                                    <td style="font-size: 12px !important; "> {{row.form_response.response_by != 0 ?row.get_response_by_name.response_by_name.name:'Anynomus'}}</td>
                                    <td style="font-size: 12px !important; ">{{row.user?row.user.name:''}}</td>
<!--                                    <td style="font-size: 12px !important; ">{{ moment(row.updated_at).format("DD-MM-YYYY") }}</td>-->
                                    <td style="font-size: 12px !important; ">{{row.from_department?row.from_department.name:''}}</td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="register-title">
                                <h4>Data</h4>
                            </div>
                            <div class="card-body">
                                <table style="border: none !important;" class="table table-borderless">
                                    <tbody>
                                    <tr style="height: 30px !important;">
                                        <th style="padding: 0px !important;" scope="row">Date</th>
                                        <td  style="padding: 0px !important;">: {{data.response_date}}</td>
                                    </tr>
                                    <tr style="height: 30px !important;" v-for="(row,index) in orderedResponse" :key="row.id">
                                        <th  style="padding: 0px !important;" scope="row">{{row.fields.field_label}}</th>
                                        <td style="padding: 0px !important;">: <a target="_blank" v-if="row.fields.field_type == 'fileupload'" :href="row.response_value">View File</a>
                                            <span v-else> {{ row.response_value }}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="register-title" style="margin: 0 auto;">
                                <button
                                        type="button" class="save_form"
                                        v-show="submissionMode"
                                        @click="Edit"
                                >Edit</button>
                            </div>
                        </div>
                    </div>
            </div>
        </div>

        <!--         Content end-->
    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'
import { Datetime } from 'vue-datetime'
import moment from 'moment'

export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['data','title','submissionMode','flash','errors','link','label'],
    data() {
        return {
            moment: moment,
        }
    },
    computed: {
        orderedResponse: function () {
            return _.orderBy(this.data.response, 'id')
        }
    },
    mounted() {
    },
    methods: {
        Edit(){
            this.$inertia.get('/form/response/' + this.data.id +'/edit-data')
        },
    }
}
</script>
