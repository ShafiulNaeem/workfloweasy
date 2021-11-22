<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
<!--        Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Manage Users</a>
                    </nav>
                </div>
            </div>
        </div>
<!--        Navbar top End-->


        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-show="!editMode" class="breadcrumb-item">  {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item">  {{title}}</li>
            </ol>
        </nav>

        <div class="register-form">
            <form class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6">
                     <!-- <div>
                        <div class="form-group">
                                <label>Roles<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.user_id">
                                    <option v-for="user in data.data" :value="user.user_id" :key="user.user_id">{{user_id.user_id}}</option>
                                </select>
                        </div>
                    </div> -->
                     <div>
                        <div class="form-group">
                            <label>User Id <span class="text-red">*</span></label>
                            <input class="form-control" disabled type="text"  v-model="form.user_code"/>
                        </div>
                    </div>

                    <div>
                        <div class="form-group">
                            <label> Email <span class="text-red">*</span></label>
                            <input class="form-control" type="email" v-model="form.email"/>
                            <div class="text-danger" v-if="errors.email">{{ errors.email[0] }}</div>
                        </div>
                    </div>
                    <!-- <div>
                        <div class="form-group">
                                <label>Roles<span class="text-red">*</span></label>
                                <select class="form-control select" v-model="form.role_id">
                                    <option v-for="roles in data.roles" :value="roles.id" :key="roles.id">{{roles.name}}</option>
                                </select>
                        </div>
                    </div> -->
                </div>
                <div class="col-12 col-md-6">
                    <div>
                        <div class="form-group">
                            <label>Name <span class="text-red">*</span></label>
                            <input class="form-control" type="text"  v-model="form.name"/>
                            <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                        </div>
                    </div>
                    <div>
                        <div class="form-group">
                            <label>Phone <span class="text-red">*</span></label>
                            <input class="form-control" type="text"  v-model="form.phone"/>
                            <div class="text-danger" v-if="errors.phone">{{ errors.phone[0] }}</div>
                        </div>
                    </div>
                                         <div>
                        <div class="form-group">
                            <label>Active Status <span class="text-red">*</span></label><br/>
                            <div class="form-check form-check-inline">
                                <input
                                    v-model="form.is_active"
                                    class="form-check-input"
                                    type="radio"
                                    name="is_active"
                                    v-bind:value="1"

                                />
                                <label
                                    class="form-check-label"
                                    for="product_active"
                                >
                                    Active
                                </label>

                            </div>
                            <div class="form-check form-check-inline">
                                <input
                                    v-model="form.is_active"
                                    class="form-check-input"
                                    type="radio"
                                    name="is_active"
                                    v-bind:value="0"
                                />
                                <label
                                    class="form-check-label"
                                    for="product_inactive"
                                >
                                    Inactive
                                </label>
                            </div>
                            <div class="text-danger" v-if="errors.is_active">{{ errors.is_active[0] }}</div>
                        </div>
                    </div>
                    <div class="m-t-50 text-center">
                        <button
                            type="button"
                            class="save"
                            v-show="editMode"
                            wire:click.prevent="store()"
                            @click="update(form)"
                        >
                            Update
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'

export default {
    components: {
        Alert
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data() {
        return {
            isOpen: false,
            photo: '',
            form: {
                id: undefined,
                name: null,
                email: null,
                phone: null,
                password: null,
                is_active: this.data.is_active,
                role_id: 6,
                user_code: this.data.code,

            },
        }
    },
    created() {
        if (this.editMode) {
            this.form = this.data
        }
    },
    methods: {
        reset: function () {
            this.form = {
                name: null,
                email: null,
                is_active: 1,
                role_id: 6,
            }
        },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },

        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.editMode = true;
            this.openModal();
        },
        update: function (params) {
            var data = new FormData()
            data.append('id', params.id || '')
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('is_active', params.is_active || '')
            // data.append('role_id', params.role_id || '')
            // data.append('user_id', params.user_id || '')
             data.append('_method', 'PUT')
             this.$inertia.patch('/admins/' + params.id, params)
        },
        // updatePer: function(){
        //     console.log('clicked per');
        // },
        EditPass: function(){
            console.log('clicked pass');
        },
        resetPass: function(){
            console.log('clicked res');
        }
    }
}
</script>
