<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>this: {{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left"></i> Manage Roles</a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li v-show="!editMode" class="breadcrumb-item"> {{title}}</li>
                <li v-show="editMode" class="breadcrumb-item"> {{title}}</li>
            </ol>
        </nav>


<!-- <slot name="header"></slot>-->

        <div class="register-form">
            <div class="col-lg-8 offset-lg-2 from-wrapper">
                    <form>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Name <span class="text-red">*</span></label>
                                    <input class="form-control" type="text" v-model="form.name"/>
                                    <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div v-for="per in data.permission" :key="per.id" class="row justify-content-center">

                                        <input class="form-control" style="width: 15px; margin-top: -10px;" :value="per.id" type="checkbox" v-model="form.permissions"/>
                                        <div class="text-danger" v-if="errors.permissions">{{ errors.permissions[0] }}</div>
                                        <label style="padding-left:5px;">{{per.name}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="m-t-20 text-center">
                            <button
                                type="button"
                                class="save_role"
                                wire:click.prevent="store()"
                                v-show="!editMode"
                                @click="save(form)"
                            >
                                Save
                            </button>
                            <button
                                type="button"
                                class="save_role"
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

export default {
    components: {
        Alert,
        datetime: Datetime
    },

    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            photo: null,
            form: {
                id: undefined,
                name: null,
                permissions: []

            }
        }
    },

    created () {
        if (this.editMode) {
            this.form = this.data
        }
    },
    methods: {
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('permissions', params.permissions || '')


            this.$inertia.post('/roles', data)
        },
        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('permissions', params.permissions || '')
            data.append('_method', 'PUT')

            this.$inertia.post('/roles/' + params.id, data)
        }
    }
}
</script>
