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
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Mail Settings</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-if="createMode" class="breadcrumb-item">Mail Settings</li>
                <li v-if="createMode" class="breadcrumb-item"> {{title}}</li>
                <li v-else class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <div class="col-lg-12  from-wrapper">
                <form>
                    <div class="row justify-content-center">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Protocol <span class="text-red">*</span></label>
                                <input  class="form-control" type="text" v-model="form.protocol" placeholder="smtp"/>
                                <div class="text-danger" v-if="errors.protocol">{{ errors.protocol[0] }}</div>
                            </div>
                        </div>
                      
                        <div class="col-sm-6" >
                            <div class="form-group" >
                                <label>Mail Type <span class="text-red">*</span></label>
                                <Select2  v-model="form.type"
                                        :options="mailOptions"
                                />
                             </div>
                        </div>

                        <div class="col-sm-6" v-if ="this.data.user_type == 'admin'">
                            <div class="form-group" >
                            <label>Organization<span class="text-red">*</span></label>
                            <Select2  @change="getData()" v-model="form.organization_id"
                                    :options="myOptions"
                            />
                            <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                        </div>
                        </div>
                         <div class="col-sm-6">
                            <div class="form-group">
                                <label>Smtp Host <span class="text-red">*</span></label>
                                <input  class="form-control" type="text" v-model="form.host" placeholder="ssl://smtp.googlemail.com"/>
                                <div class="text-danger" v-if="errors.host">{{ errors.host[0] }}</div>
                            </div>
                        </div>
                        <div :class="this.data.user_type == 'admin'?'col-sm-4':'col-sm-6' ">
                            <div class="form-group">
                                <label>Smtp Port <span class="text-red">*</span></label>
                                <input  class="form-control" type="text" v-model="form.port" placeholder="8080"/>
                                <div class="text-danger" v-if="errors.port">{{ errors.port[0] }}</div>
                            </div>
                        </div>
                         <div :class="this.data.user_type == 'admin'?'col-sm-4':'col-sm-6' ">
                            <div class="form-group">
                                <label>Sender Email <span class="text-red">*</span></label>
                                <input  class="form-control" type="email" v-model="form.email" placeholder="example@gmail.com"/>
                                <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                            </div>
                        </div>
                        <div :class="this.data.user_type == 'admin'?'col-sm-4':'col-sm-6' ">
                            <div class="form-group">
                                <label> Password<span class="text-red">*</span></label>
                                <input class="form-control" type="password" v-model="form.password" placeholder="passowrd"/>
                                <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>
                            </div>
                        </div>

                        <!-- <div class="col-sm-6" v-if="$page.auth.user.user_type == 'admin'">
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

                        </div> -->

                    </div>

                    <div class="m-t-20 text-center">
                        <button style="margin-top: 25px;"
                            type="button" class="save"
                            wire:click.prevent="store()"
                            v-show="createMode"
                            @click="save(form)">
                            Save
                        </button>
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
            mailOptions:[
                {id: 'html', text: 'html'},
                {id: 'css', text: 'css'},
                ],
            photo: null,
            form: {
                index:'',
                id: undefined,
                protocol:null,
                type:null,
                host:null,
                port:null,
                email:null,
                password:null,
                organization_id: null,
            }
        }
    },
    created () {
        if (this.editMode) {
            this.form = this.data
            this.form.password = null
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

            this.$inertia.post('/type', data)
            this.form = {}
        },
        save: function (params) {

            var data = new FormData()
            data.append('protocol', params.protocol || '')
            data.append('type', params.type || '')
            data.append('host', params.host || '')
            data.append('port', params.port || '')
            data.append('email', params.email || '')
            data.append('password', params.password || '')
            data.append('organization_id', params.organization_id || '')

            this.$inertia.post('/mail', data)
        },
        update: function (params) {
            var data = new FormData()
            data.append('protocol', params.protocol || '')
            data.append('type', params.type || '')
            data.append('host', params.host || '')
            data.append('port', params.port || '')
            data.append('email', params.email || '')
            data.append('password', params.password || '')
            data.append('organization_id', params.organization_id|| '')
            data.append('_method', 'PUT')

            this.$inertia.post('/mail/' + params.id, data)
        },
        Edit(){
            this.$inertia.get('/type/' + this.data.id +'/edit')
        },

    }
}
</script>
