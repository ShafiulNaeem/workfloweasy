<template>
    <form>
        <div>
            <div class="col-md-8 card-box">
                <div class="form-group">
                    <label for="name">Form Title<span class="text-red">*</span></label>
                    <input type="text" class="form-control" id="name" v-model="form.Form_title">
                    <div class="text-danger" v-if="errors.Form_title">{{ errors.Form_title[0] }}</div>
                </div>
                <div class="form-group">
                    <label for="des">Form Description</label>
                    <textarea id="des" cols="30" rows="10" class="form-control" v-model="form.description"></textarea>
                    <div class="text-danger" v-if="errors.description">{{ errors.description[0] }}</div>
                </div>

                <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">
                    <label>Organization<span class="text-red">*</span></label>
<!--                    <select class="form-control select" @change="getData()" v-model="form.organization_id" >-->
<!--                        <option class="selected" v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>-->
<!--                    </select>-->
                    <Select2  @change="getData()" v-model="form.organization_id"
                             :options="myOptions"
                    />

                    <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                </div>

                <div v-if="data.mode == 'edit'">
                    <div class="form-group">
                        <label>Category<span class="text-red">*</span></label>
                        <multiselect v-model="form.categories"
                                     tag-placeholder="Select category"
                                     placeholder="Search category"
                                     label="name"
                                     track-by="id"
                                     :options="categories"
                                     :multiple="true"
                                     :taggable="true"
                        ></multiselect>
                        <div class="text-danger" v-if="errors.category_ids">{{ errors.category_ids[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label>Department<span class="text-red">*</span></label>
                        <multiselect v-model="form.departments"
                                     tag-placeholder="Select department"
                                     placeholder="Search department"
                                     label="name"
                                     track-by="id"
                                     :options="departments"
                                     :multiple="true"
                                     :taggable="true"
                        ></multiselect>
                        <div class="text-danger" v-if="errors.department_ids">{{ errors.department_ids[0] }}</div>
                    </div>

                    <div class="form-group">
                            <label>Types<span class="text-red">*</span></label>
                            <multiselect v-model="form.types"
                                         tag-placeholder="Select type"
                                         placeholder="Search type"
                                         label="name"
                                         track-by="id"
                                         :options="types"
                                         :multiple="true"
                                         :taggable="true"

                            ></multiselect>
                            <div class="text-danger" v-if="errors.type_ids">{{ errors.type_ids[0] }}</div>
                        </div>

                </div>

                <div v-else>
                    <div class="form-group">
                        <label>Category<span class="text-red">*</span></label>
                        <multiselect v-model="form.categories"
                                     tag-placeholder="Select category"
                                     placeholder="Search category"
                                     label="name"
                                     track-by="id"
                                     :options="categories"
                                     :multiple="true"
                                     :taggable="true"

                        ></multiselect>
                        <div class="text-danger" v-if="errors.category_ids">{{ errors.category_ids[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label>Department<span class="text-red">*</span></label>
                        <multiselect v-model="form.departments"
                                     tag-placeholder="Select department"
                                     placeholder="Search department"
                                     label="name"
                                     track-by="id"
                                     :options="departments"
                                     :multiple="true"
                                     :taggable="true"
                        ></multiselect>
                        <div class="text-danger" v-if="errors.department_ids">{{ errors.department_ids[0] }}</div>
                    </div>


                    <div class="form-group">
                            <label>Types<span class="text-red">*</span></label>
                            <multiselect v-model="form.types"
                                         tag-placeholder="Select type"
                                         placeholder="Search type"
                                         label="name"
                                         track-by="id"
                                         :options="types"
                                         :multiple="true"
                                         :taggable="true"


                            ></multiselect>
                            <div class="text-danger" v-if="errors.type_ids">{{ errors.type_ids[0] }}</div>
                        </div>

                </div>

                <div class="m-t-50 text-center">
                    <button style="right:0%"
                        type="button"
                        class="save pull-right m-t-30"
                        wire:click.prevent="store()"
                        v-show="!data.mode"
                        @click="save(form)"
                    >
                        Next
                    </button>
                </div>
                <div class="m-t-20 text-center">
                    <button style="right:0%"
                        type="button"
                        class="save pull-right m-t-30"
                        wire:click.prevent="store()"
                        v-show="data.mode === 'edit'"
                        @click="update(form)"
                    >
                        Next
                    </button>
                </div>
            </div>
        </div>

    </form>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import {HTTP} from '@/utils/http-common'
import Multiselect from 'vue-multiselect';
import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        datetime: Datetime,
        Multiselect,
        Select2
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            myOptions:[{id: null, text: ''}],
            categories:[],
            departments:[],
            types:[],
            // selected_departments:[],
            // selected_categories:[],
            // selected_types:[],
            form: {
                departments:[],
                categories:[],
                types:[],
                id: undefined,
                Form_title: "",
                description: "",

            }
        }
    },

    created () {

        this.categories = this.data.all_categories;
        this.departments = this.data.all_departments;
        this.types = this.data.all_types;

        if (this.data.mode === 'edit') {
            this.form = this.data;
            this.selected_departments = this.data.departments;
            this.selected_categories = this.data.categories;
            this.selected_types = this.data.types;
        }

        let i = 0
        for(i=0; i<this.data.organizations.length; i++){
            this.myOptions.push({
                id: this.data.organizations[i].id,
                text: this.data.organizations[i].name
            })
        }

    },
    methods: {
        getData: function () {

            HTTP.get('/organization/get-data/'+this.form.organization_id)
                .then((response)=>{
                    this.departments = response.data.departments;
                    this.categories = response.data.categories;
                    this.types = response.data.types;
                })
        },

        reset: function () {
            this.form = {}
        },
        save: function (params) {
           let departments = [];
            params.departments.forEach(function(data) {
                departments.push(data['id'])
            });


            let categories = [];
            params.categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            params.types.forEach(function(data) {
                types.push(data['id'])
            });

            params['department_ids'] = departments;
            params['category_ids'] = categories;
            params['type_ids'] = types;

            this.$inertia.post('/forms/create', params)
        },
        update: function (params) {


            let departments = [];
            params.departments.forEach(function(data) {
                departments.push(data['id'])
            });


            let categories = [];
            params.categories.forEach(function(data) {
                categories.push(data['id'])
            });

            let types = [];
            params.types.forEach(function(data) {
                types.push(data['id'])
            });


            let data = {}
            data['Form_title'] = params.Form_title;
            data['description'] = params.description;
            data['organization_id'] = params.organization_id;
            data['department_ids'] = departments;
            data['category_ids'] = categories;
            data['type_ids'] = types;

            this.$inertia.put('/forms/'+ this.data.id +'/update-form-info', data)
        },

    }
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
