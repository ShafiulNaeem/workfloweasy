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


                </div>
                <div class="col-12 col-md-6">
                    <div>
                        <div class="form-group">
                            <label>Name <span class="text-red">*</span></label>
                            <input class="form-control" type="text"  v-model="form.name"/>
                            <div class="text-danger" v-if="errors.name">{{ errors.name[0] }}</div>
                        </div>
                    </div>

                    <div class="m-t-50 text-center">
                        <a v-show="editMode" :href="route('admin/personal', [this.data.id])" class="save" type="button">Edit Persoanl</a>
                        <a v-show="editMode" :href="route('admin/reset', [this.data.id])" class="reset-pass" type="button">Reset Password</a>
                        <a v-show="editMode" :href="route('admin/password', [this.data.id])" class="save1" type="button">Edit Password</a>
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
                is_active: 1,
                role_id: 6,
                user_code: this.data.code,
                create_another: null

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
        save: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.role_id || '')
            data.append('user_code', params.user_code || '')
            this.$inertia.post('/admins', params)
        },
        saveAndAnother: function (params) {
            this.form.create_another = 1
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('email', params.email || '')
            data.append('phone', params.phone || '')
            data.append('password', params.password || '')
            data.append('confirm_password', params.confirm_password || '')
            data.append('is_active', params.is_active || '')
            data.append('user_id', params.role_id || '')
            data.append('user_code', params.user_code || '')
            data.append('create_another', params.create_another || '')

            this.$inertia.post('/admins', params)
        },
        edit: function (data) {
            this.form = Object.assign({}, data);
            this.form.password = null;
            this.editMode = true;
            this.openModal();
        },


    }
}
</script>
