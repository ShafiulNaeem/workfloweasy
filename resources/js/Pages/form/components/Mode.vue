<template>
    <div class="page-wrapper user-color" style="padding-bottom: 20px;">

        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> {{label}}</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item"> {{label}} </li>
                <li v-show="!editMode" class="breadcrumb-item"> {{ title }}</li>
                <li v-show="editMode" class="breadcrumb-item"> {{ title }}</li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-lg-12">
                    <form>
                      <div class="row justify-content-center">
                        <div class="col-md-8 card-box">
                          <div class="form-group">
                            <label for="name">Form Title<span class="text-red">*</span></label>
                            <input type="text" class="form-control" id="name" v-model="form.Form_title">
                              <div class="text-danger" v-if="errors.Form_title">{{ errors.Form_title[0] }}</div>
                          </div>
                          <div class="form-group">
                            <label for="des">Form Description</label>
                            <textarea id="des" cols="30" rows="10" class="form-control" v-model="form.description"></textarea>
                          </div>

                          <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">
                            <label>Organization<span class="text-red">*</span></label>
                            <select class="form-control select" @change="getCategories()" v-model="form.organization_id" >
                              <option class="selected" v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                            </select>
                              <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                          </div>



                          <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">
                            <label>Category<span class="text-red">*</span></label>
                            <select class="form-control select" v-model="form.category_id">
                              <option  v-for="cat in categories" :value="cat.id" :key="cat.id">{{cat.name}}</option>
                            </select>
                              <div class="text-danger" v-if="errors.category_id">{{ errors.category_id[0] }}</div>
                          </div>

                          <div class="form-group" v-if = "$page.auth.user.user_type != 'admin'">
                            <label>Category<span class="text-red">*</span></label>
                            <select class="form-control select" v-model="form.category_id">
                              <option v-for="cat in data.categories" :value="cat.id" :key="cat.id">{{cat.name}}</option>
                            </select>
                              <div class="text-danger" v-if="errors.category_id">{{ errors.category_id[0] }}</div>
                          </div>


                          <div class="form-group" v-if = "$page.auth.user.user_type == 'admin'">
                            <label>Department<span class="text-red">*</span></label>
                            <select class="form-control select" v-model="form.from_department_id">
                              <option v-for="cat in departments" :value="cat.id" :key="cat.id">{{cat.name}}</option>
                            </select>
                              <div class="text-danger" v-if="errors.from_department_id">{{ errors.from_department_id[0] }}</div>
                          </div>

                            <div class="form-group" v-if = "$page.auth.user.user_type != 'admin'">
                                <label>Department<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.from_department_id">
                                    <option v-for="cat in data.departments" :value="cat.id" :key="cat.id">{{cat.name}}</option>
                                </select>
                                <div class="text-danger" v-if="errors.from_department_id">{{ errors.from_department_id[0] }}</div>
                            </div>

                        </div>
                      </div>
                        <div class="m-t-20 text-center">
                            <button
                                type="button"
                                class="save_form"
                                wire:click.prevent="store()"
                                v-show="!editMode"
                                @click="save(form)"
                            >
                                Create Form
                            </button>
                        </div>
                    </form>
            </div>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import {HTTP} from '@/utils/http-common'

export default {
    components: {
        Alert,
        datetime: Datetime
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            categories:[],
            departments:[],
            form: {
                id: undefined,
                Form_title: "",
                description: "",


            }
        }
    },

    created () {

        if (this.editMode) {
            this.form = this.data
        }
    },
    methods: {

      getCategories: function () {
          HTTP.get('/getcategories/'+this.form.organization_id)
              .then((response)=>{
                  // this.form = response.data.bill;
                  this.categories = response.data;
                  console.log(this.categories)
              })
          this.getDepartment();
      },
      getDepartment: function () {
          HTTP.get('/get_department/'+this.form.organization_id)
              .then((response)=>{
                  // this.form = response.data.bill;
                  this.departments = response.data;
              })
      },
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            var data = new FormData()
            this.$inertia.post('/forms/create', params)
        },
    }
}
</script>
