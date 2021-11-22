<template>
    <form>
            <div class="row">
                <div class="col-md-5 card-box">
                <h6 class="my-2">Report Information</h6>
                <div class="form-group">
                    <label v-if="data.is_for_automation == 'YES'" for="name">Report Automation Name<span class="text-red">*</span></label>
                    <label v-else for="name">Report Name<span class="text-red">*</span></label>
                    <input type="text" class="form-control" id="name" v-model="form.report_name">
                    <div class="text-danger" v-if="errors.report_name">{{ errors.report_name[0] }}</div>
                </div>
                <div class="form-group">
                    <label for="des">Report Description<span class="text-red">*</span></label>
                    <textarea id="des" cols="30" rows="10" class="form-control" v-model="form.description"></textarea>
                    <div class="text-danger" v-if="errors.description">{{ errors.description[0] }}</div>
                </div>
                <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">
                    <label>Organization<span class="text-red">*</span></label>
                    <Select2  @change="getData()" v-model="form.organization_id"
                             :options="myOptions"
                    />
                    <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                </div>
                <div class="form-group ">
                    <label>Categories<span class="text-red">*</span></label>
                    <multiselect v-model="selected_categories"
                                    tag-placeholder="Select form category"
                                    placeholder="Search form category"
                                    label="name"
                                    track-by="id"
                                    :options="categories"
                                    :multiple="true"
                                    :taggable="true"
                    >
                    </multiselect>
                    <div class="text-danger" v-if="errors.category_ids">The Categories field is required.</div>
                </div>
                 <div class="form-group ">
                    <label>Departments<span class="text-red">*</span></label>
                    <multiselect v-model="selected_departments"
                                    tag-placeholder="Select form category"
                                    placeholder="Search form category"
                                    label="name"
                                    track-by="id"
                                    :options="departments"
                                    :multiple="true"
                                    :taggable="true"
                    >
                    </multiselect>
                    <div class="text-danger" v-if="errors.department_ids">The Departments field is required.</div>
                </div>
                <div class="form-group ">
                    <label>Types<span class="text-red">*</span></label>
                    <multiselect v-model="selected_types"
                                    tag-placeholder="Select form category"
                                    placeholder="Search form category"
                                    label="name"
                                    track-by="id"
                                    :options="types"
                                    :multiple="true"
                                    :taggable="true"
                    >
                    </multiselect>
                    <div class="text-danger" v-if="errors.type_ids">The Types field is required.</div>
                </div>
                </div>
                <div class="col-md-5 ml-3 card-box">
                    <h6 class="my-2">Select Form</h6>
                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Form Category<span class="text-red">*</span></label>
                            <Select2 @change="getCategory()" v-model="form.category_id"
                                    :options="catsOptions"
                            />
                            <div class="text-danger" v-if="errors.category_id">The Form Category is required.</div>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Form Name<span class="text-red">*</span></label>
                            <Select2 v-model="form.form_id"
                                    :options="formsOptions"
                            />
                            <div class="text-danger" v-if="errors.form_id">The Form name is required.</div>
                        </div>
                    </div>

                   <h6>Report Type</h6>
                   <div class="d-flex justify-content-between">
                        <div>
                            <input type="radio" name="tabular"  value="SINGLE" v-model="form.type"/> Single Tabular
                            <div class="my-3">
                                <img v-bind:src="'/assets/images/single_compare.png'"  width="70" height="auto" alt="">
                            </div>
                            <p class="mt-3">Tabular report provide you the way to list you data in </p>
                        </div>
                        <div class="ml-1">
                            <input type="radio" name="tabular"  value="COMPARE" v-model="form.type"/> Compare Tabular
                            <div class="my-3">
                                <img v-bind:src="'/assets/images/multi_compare.png'"  width="70" height="auto" alt="">
                            </div>
                             <p class="mt-3">Compare tabular reports compare between two data range of data</p>
                        </div>
                   </div>
                    <br>
                    <div v-show="data.edit == 'yes' && data.is_for_automation == 'YES'" class="form-group">
                        <label>Report Generation Interval(Hours) <span class="text-red">*</span></label>
                        <input class="form-control" type="number"  v-model="form.interval"/>
<!--                        <div class="text-danger" v-if="error_interval == 1">The interval field is required.</div>-->
                    </div>
<!--                    <div v-show="data.edit == 'yes' && data.is_for_automation == 'YES'" class="form-group">-->
<!--                        <label>Report Duration (Days) <span class="text-red">*</span></label>-->
<!--                        <input class="form-control" type="number"  v-model="form.duration"/>-->
<!--&lt;!&ndash;                        <div class="text-danger" v-if="error_duration == 1">The interval field is required.</div>&ndash;&gt;-->
<!--                    </div>-->
                    <div v-show="data.edit == 'yes' && data.is_for_automation == 'YES'" class="form-group">
                        <label>Start Date (Date and Time) <span class="text-red">*</span></label>
                        <input class="form-control" type="datetime-local"  v-model="form.last_running_time"/>
<!--                        <div class="text-danger" v-if="error_last_running_time == 1">The Start Date field is required.</div>-->
                    </div>

                </div>
            </div>
            <div class="col-md-10 mb-5">
                  <div class="m-t-10 text-center">
                    <button
                       type="button"
                       class="form-submit-btn  pull-right  ml-10"
                       wire:click.prevent="store()"
                       @click="save(form, 'next')"
                       >
                       Next
                   </button>

                    <button
                        style="background-color: #FF451A"
                        type="button"
                        class="form-submit-btn  ml-10  pull-right "
                        wire:click.prevent="store()"
                        @click="cancel()"
                    >
                        Cancel
                    </button>


                </div>
            </div>
    </form>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import {HTTP} from '@/utils/http-common'
import Multiselect from 'vue-multiselect';
import Select2 from 'v-select2-component';
import Input from '../../../../Jetstream/Input.vue';
import moment from "moment";

export default {
    components: {
        Alert,
        datetime: Datetime,
        Multiselect,
        Select2,
        Input
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
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
        if (this.data.edit == 'yes') {
            this.form = this.data;

            if (this.data.is_for_automation == 'YES'){
                this.form.last_running_time = moment(this.data.last_running_time).format("yyyy-MM-DDTHH:mm")
            }

            //get Forms
            this.forms = this.data.all_forms;
            var k = 0
            // this.formsOptions=[]
            for(k=0; k<this.forms.length; k++){
                this.formsOptions.push({
                    id: this.forms[k].id,
                    text: this.forms[k].Form_title
                })
            }


            this.categories = this.data.all_categories;
            this.departments = this.data.all_departments;
            this.types = this.data.all_types;

            this.selected_departments = this.data.departments;
            this.selected_categories = this.data.categories;
            this.selected_types = this.data.types;
        }

        // organizations for admin
        if (this.data.user_type == 'admin'){
            let i = 0
            for(i=0; i<this.data.organizations.length; i++){
                this.myOptions.push({
                    id: this.data.organizations[i].id,
                    text: this.data.organizations[i].name
                })

            }
        }

       // Form category
        var j = 0
        for(j=0; j<this.data.all_categories.length; j++){
            this.catsOptions.push({
                id: this.data.all_categories[j].id,
                text: this.data.all_categories[j].name
            })
        }

        // types,category,departments for user type != admin,,,
        if (this.data.user_type != 'admin'){
            HTTP.get('/organization/get-data/'+this.data.organization_id)
                .then((response)=>{
                    this.departments = response.data.departments;
                    this.categories = response.data.categories;
                    this.types = response.data.types;
                })
        }


    },
    methods: {
        handleCompare: function(text, id){
            this.compare = text;
        },
        handleForms(){
            var k = 0
            this.formsOptions=[]
            for(k=0; k<this.forms.length; k++){
                this.formsOptions.push({
                    id: this.forms[k].id,
                    text: this.forms[k].Form_title
                })
            }
           // console.log(this.forms.length);
        },
        getData: function () {
            HTTP.get('/organization/get-data/'+this.form.organization_id)
                .then((response)=>{
                    this.departments = response.data.departments;
                    this.categories = response.data.categories;
                    this.types = response.data.types;
                })
        },
        getCategory: function () {
            HTTP.get('/category/get-data/'+this.form.category_id)
                .then((response)=>{
                    this.forms = response.data.all_forms;
                    // console.log(this.form.form_id)
                    this.handleForms()
                })
        },
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            let departments = [];
            this.selected_departments.forEach(function(data) {
                departments.push(data['id'])
            });

            let categories = [];
            this.selected_categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            this.selected_types.forEach(function(data) {
                types.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;
             // console.log(params.id)
            var data = new FormData()

            if (this.data.edit == 'yes'){
                params['_method']= 'PUT'
                this.$inertia.post('/report/' + params.id, params)
            }else {
                params['is_for_automation'] = this.data.is_for_automation;
                params['interval'] =  this.data.interval;
                // params['duration'] =  this.data.duration;
                params['last_running_time'] =  this.data.last_running_time;

                this.$inertia.post('/report', params)
            }

        },
        cancel(){
            this.$inertia.get('/report')
        }

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
