<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2 >{{ data.name }}</h2>
                </div>

            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item"> {{title}}</li>
            </ol>
        </nav>

        <!-- Content Start-->
        <div class="register-form">
            <div class="register-title">
                <h4>Organization Information </h4>
            </div>
            <form action="" class="d-md-flex from-wrapper">
                <div class="col-12 col-md-6">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Company Name</label>
                        <input type="text" required class="form-control disabled" id="exampleFormControlInput1" v-model="form.name">
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Email</label>
                        <input type="email" required class="form-control disabled" id="exampleFormControlInput2" v-model="form.email" placeholder="Email:">
                    </div>

                    <div class="form-group">
                        <label for="inputPassword5"> Phone</label>
                        <input  type="text" id="inputPassword5" class="form-control disabled" v-model="form.phone" aria-describedby="passwordHelpBlock" placeholder=" Phone:">
                    </div>

                    <div class="form-group">
                        <label for="inputPassword5">Website</label>
                        <input type="text" id="inputPassword6" class="form-control disabled" v-model="form.website" aria-describedby="passwordHelpBlock" placeholder="https://">
                    </div>

                    <div class="form-group">
                        <label for="my-textarea">Status</label>
                        <select class="form-control select disabled" v-model="form.status">
                            <option value="1">Active</option>
                            <option value="2">Maintenance </option>
                            <option value="3">Suspended</option>
                        </select>
                    </div>

                </div>

                <div class="col-12 col-md-6 submit-btn-rl">
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Code</label>
                        <input type="text" required class="form-control disabled" id="exampleFormControlInput1" v-model="form.code">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Contact Person Name</label>
                        <input type="text" class="form-control disabled" v-model="form.contact_person_name" id="exampleFormControlInput1" placeholder="Contact Person Email:">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Contact Person Email</label>
                        <input type="text" class="form-control disabled" id="exampleFormControlInput3" v-model="form.contact_person_email" placeholder="Contact Person Email:">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Subscription</label>
                        <select class="form-control select disabled" v-model="form.subscriptions_id">
                            <option v-for="sub in data.subscriptions" :value="sub.id" :key="sub.id">{{sub.name}}</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Organization Group</label>
                        <select class="form-control select disabled" v-model="form.organization_groups_id">
                            <option v-for="org in data.organization_group" :value="org.id" :key="org.id">{{org.name}}</option>
                        </select>
                    </div>


                </div>
            </form>
        </div>

    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'

export default {
    name: "Details",
    components: {
        Alert,
    },
    props: ['data', 'errors','link', 'title', 'label'],
    data () {
        return {
            form: {
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
            }
        }
    },
    created () {
        this.form = this.data
    },
    methods: {
       //
    }
}
</script>

<style scoped>

</style>
