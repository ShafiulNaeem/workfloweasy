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
                        <a v-if="editMode" :href="route('organization-users.show',data.id)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i>Go Back</a>
                        <a v-else :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Organizations</a>
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
                <li v-if="!createMode" class="breadcrumb-item"> {{data.name}}</li>
            </ol>
        </nav>
<!--        <slot name="header"></slot>-->
        <div class="register-form">
            <div class="register-title">
                <h4>Organization Information</h4>
            </div>
            <form action="" class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Company Name<span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" type="text" required class="form-control" id="exampleFormControlInput1" v-model="form.name" placeholder="Company Name:">
                        <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Email <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" type="email" required class="form-control" id="exampleFormControlInput2" v-model="form.email" placeholder="Email:">
                        <div  class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword5"> Phone <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" type="text" id="inputPassword5" class="form-control" v-model="form.phone" aria-describedby="passwordHelpBlock" placeholder=" Phone:">
                        <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label for="inputPassword5">Website</label>
                        <input :class="viewMode?'disabled': ''" type="text" id="inputPassword6" class="form-control" v-model="form.website" aria-describedby="passwordHelpBlock" placeholder="https://">
                        <div class="text-danger" v-if="errors.website">{{ errors.website[0] }}</div>
                    </div>

                    <div class="form-group">
                        <input type="hidden" v-model="form.is_active">
                        <label for="my-textarea">Status</label>
                        <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.status">
                            <option value="1">Active</option>
                            <option value="2">Maintenance </option>
                            <option value="3">Suspended</option>
                        </select>
                        <Select2 v-show="!viewMode" v-model="form.status"
                                 :options="statusOption"/>
                        <div class="text-danger" v-if="errors.status">{{ errors.status[0] }}</div>
                    </div>

                </div>

                <div class="col-12 col-md-6 submit-btn-rl">

                    <div class="form-group"  v-show="!createMode">
                        <label for="exampleFormControlInput1">Code *</label>
                        <input disabled type="text" required class="form-control" id="exampleFormControlInput1" v-model="form.code">
                    </div>

                    <div class="form-group"  v-show="createMode">
                        <label for="inputPassword5"> Password <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" :type="type" id="inputPassword5" v-model="form.password" class="form-control" aria-describedby="passwordHelpBlock" placeholder=" password:">
                        <span @click="showPassword"
                              :class="type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                              class="field-icon toggle-password"
                        ></span>

                        <div class="text-danger" v-if="errors.password">{{ errors.password[0] }}</div>

                    </div>

                    <div class="form-group" v-show="createMode">
                        <label for="inputPassword5">Confirm Password <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" :type="con_type" v-model="form.confirm_password" id="inputPassword5" class="form-control" aria-describedby="passwordHelpBlock" placeholder="Confirm password">
                        <span @click="showConfirmPassword"
                              :class="con_type=='password'?'fa fa-eye fa-eye-slash':'fa fa-fw fa-eye'"
                              class="field-icon toggle-password"
                        ></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Contact Person Name <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" type="text" class="form-control" v-model="form.contact_person_name" id="exampleFormControlInput1" placeholder="Contact Person Email:">
                        <div class="text-danger" v-if="errors.contact_person_name">{{ errors.contact_person_name[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Contact Person Email <span class="text-red">*</span></label>
                        <input :class="viewMode?'disabled': ''" type="text" class="form-control" id="exampleFormControlInput3" v-model="form.contact_person_email" placeholder="Contact Person Email:">
                        <div class="text-danger" v-if="errors.contact_person_email">{{ errors.contact_person_email[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Subscription</label>
                        <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.subscriptions_id">
                            <option v-for="sub in data.subscriptions" :value="sub.id" :key="sub.id">{{sub.name}}</option>
                        </select>
                        <Select2 v-show="!viewMode" v-model="form.subscriptions_id"
                                 :options="subOption"/>
                        <div class="text-danger" v-if="errors.subscriptions_id">{{ errors.subscriptions_id[0] }}</div>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Organization Group</label>
                        <select v-show="viewMode" :class="viewMode?'disabled': ''" class="form-control select" v-model="form.organization_groups_id">
                            <option v-for="org in data.organization_group" :value="org.id" :key="org.id">{{org.name}}</option>
                        </select>
                        <Select2 v-show="!viewMode" v-model="form.organization_groups_id"
                                 :options="myOptions"/>
                        <div class="text-danger" v-if="errors.organization_groups_id">{{ errors.organization_groups_id[0] }}</div>
                    </div>


                    <input type="hidden" v-model="form.user_id">


                    <!--create button start-->
                    <button style="margin-top: 40px;"
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
                    <button style="margin-top: 40px;"
                        type="button" class="save"
                        wire:click.prevent="store()"
                        v-show="editMode"
                        @click="update(form)"
                    >Update</button>
                    <!--Edit button end-->

                    <!--Edit button start-->

                    <button style="margin-top: 40px;"
                            type="button" class="save_create"
                            v-show="viewMode"
                            @click="changePassword"

                    >Reset password</button>
                    <button style="margin-top: 40px;"
                            type="button" class="save"
                            v-show="viewMode"
                            @click="Edit"
                    >Edit</button>

                </div>
            </form>
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
            photo: null,
            myOptions:[{id: null, text: ''}],
            subOption:[{id: null, text: ''}],
            statusOption:[
                {id:1, text: 'Active'},
                {id:2, text: 'Maintenance'},
                {id:3, text: 'Suspended'}
            ],
            form: {
                index:'',
                id: undefined,
                name: null,
                code: this.data.code,
                phone: null,
                email: null,
                contact_person_name: null,
                contact_person_email: null,
                is_active: '1',
                status: '1',
                password: null,
                website: null,
                organization_groups_id:null,
                subscriptions_id:null,

            },
            type:'password',
            con_type:'password'
        }
    },
    created () {
        if (this.editMode) {
            this.form = this.data
        }
        if (this.viewMode) {
            this.form = this.data
        }

        // for organization_group
        let i = 0
        let j = 0
        for(i=0; i<this.data.organization_group.length; i++){
            this.myOptions.push({
                id: this.data.organization_group[i].id,
                text: this.data.organization_group[i].name
            })
        }
        for(j=0; j<this.data.subscriptions.length; j++){
            this.subOption.push({
                id: this.data.subscriptions[j].id,
                text: this.data.subscriptions[j].name
            })
        }
    },
    methods: {
        showPassword() {
            if(this.type === 'password') {
                this.type = 'text'
            }else {
                this.type = 'password'
            }
        },
        showConfirmPassword() {
            if(this.con_type === 'password') {
                this.con_type = 'text'
            }else {
                this.con_type = 'password'
            }
        },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        reset: function () {
            this.form = {}
        },

        save_create: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('code', params.code || '')
            data.append('website', params.website)
            data.append('password', params.password)
            data.append('confirm_password', params.confirm_password || '')
            data.append('contact_person_name', params.contact_person_name || '')
            data.append('contact_person_email', params.contact_person_email || '')
            data.append('subscriptions_id', params.subscriptions_id || '')
            data.append('organization_groups_id', params.organization_groups_id || '')
            data.append('status', params.status || '')
            data.append('is_active', params.is_active || '')

            this.$inertia.post('/organization-users', data)
            this.form = {}
        },
        save: function (params) {
            this.form.index = 'index'
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('code', params.code || '')
            data.append('website', params.website)
            data.append('password', params.password)
            data.append('confirm_password', params.confirm_password || '')
            data.append('contact_person_name', params.contact_person_name || '')
            data.append('contact_person_email', params.contact_person_email || '')
            data.append('subscriptions_id', params.subscriptions_id || '')
            data.append('organization_groups_id', params.organization_groups_id || '')
            data.append('status', params.status || '')
            data.append('is_active', params.is_active || '')
            data.append('index', params.index || '')

            this.$inertia.post('/organization-users', data)

        },

        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('code', params.code || '')
            data.append('website', params.website)
            data.append('old_password', params.old_password || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('contact_person_name', params.contact_person_name || '')
            data.append('contact_person_email', params.contact_person_email || '')
            data.append('subscriptions_id', params.subscriptions_id || '')
            data.append('organization_groups_id', params.organization_groups_id || '')
            data.append('status', params.status || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.user_id || '')
            data.append('_method', 'PUT')

            this.$inertia.post('/organization-users/' + params.id, data)
        },

        Edit(){
            this.$inertia.get('/organization-users/' + this.data.id +'/edit')
        },
        changePassword(){
            this.$inertia.get('/organization-users/changePassword/' + this.data.id)
        }
    }
}
</script>
