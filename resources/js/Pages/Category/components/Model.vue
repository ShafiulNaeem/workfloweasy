<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2 v-if="createMode">{{ title }}</h2>
                    <h2 v-else>{{ data.name }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a v-if="editMode" :href="route('categories.show',data.id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                        <a v-else :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Categories</a>
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
                <li v-show="!createMode" class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <div class="col-lg-8 offset-lg-2 from-wrapper">
                <form>
                    <div class="row justify-content-center">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Name <span class="text-red">*</span></label>
                                <input :class="viewMode?'disabled': ''" class="form-control" type="text" v-model="form.name"/>
                                <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
<!--                                <input  class="form-control" type="text" v-model="form.created_by" :value="$page.auth.user.user_type"/>-->
                            </div>
                        </div>

                        <div class="col-sm-6" v-if="$page.auth.user.user_type == 'admin'">
                            <div class="form-group">
                                <label>Organization<span class="text-red">*</span></label>
                                <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.organization_id">
                                    <option v-for="org in data.organizations" :value="org.id" :key="org.id">{{org.name}}</option>
                                </select>
                                <Select2 v-show="!viewMode" v-model="form.organization_id"
                                         :options="myOptions"
                                />
                                <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                            </div>
                        </div>
                    </div>

                    <div class="m-t-20 text-center">
                        <!--create button start-->
                        <button style="margin-top: 40px; right: 18% !important;"
                                type="button" class="save_create"
                                wire:click.prevent="store()"
                                v-show="createMode"
                                @click="save_create(form)"

                        >Save & Create Another</button>
                        <button style="margin-top: 40px;"
                                type="button" class="save"
                                wire:click.prevent="store()"
                                v-show="createMode"
                                @click="save(form)"
                        >Save</button>
                        <!--create button end-->

                        <!--Edit button start-->
                        <button
                            type="button"
                            class="save"
                            wire:click.prevent="store()"
                            v-show="editMode"
                            @click="update(form)"
                        >
                            Update
                        </button>
                        <!--Edit button end-->
                        <button
                            type="button" class="save"
                            v-show="viewMode"
                            @click="Edit"
                        >Edit</button>
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

import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        datetime: Datetime,
        Select2
    },

    props: ['data', 'errors','createMode','viewMode', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            myValue: '',
            myOptions:[{id: null, text: ''}],
            photo: null,
            form: {
                index:'',
                id: undefined,
                organization_id: null,
                org_id: null,
                Package_id:null
            }
        }
    },
    created () {
        if (this.editMode) {
            this.form = this.data
        }

        if (this.viewMode) {
            this.form = this.data
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
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        reset: function () {
            this.form = {}
        },
        save_create: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('organization_id', params.organization_id || '')

            this.$inertia.post('/categories', data)
            this.form = {}
        },
        save: function (params) {
            this.form.index = 'index'
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('organization_id', params.organization_id || '')
            data.append('index', params.index || '')

            this.$inertia.post('/categories', data)
        },
        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('organization_id', params.organization_id || '')
            data.append('_method', 'PUT')

            this.$inertia.post('/categories/' + params.id, data)
        },
        Edit(){
            this.$inertia.get('/categories/' + this.data.id +'/edit')
        },
    }
}
</script>
