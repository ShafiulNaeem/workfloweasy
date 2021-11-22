<template>
    <div class="page-wrapper user-color" style="padding-bottom: 20px;">

        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
<!--                    <h2 v-if="data.mode=='edit'">{{ data.Form_title}}</h2>-->
                    <h2 v-if="data.step != 'one'">{{data.form.Form_title}}</h2>
                    <h2 v-else-if="data.mode == 'edit' ">{{data.Form_title}}</h2>
                    <h2 v-else>{{title}}</h2>
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
                <li v-if ="data.mode=='edit'" class="breadcrumb-item"> Update Form</li>
                <li v-else class="breadcrumb-item"> {{ title }}</li>
                <li  v-if ="data.mode=='edit'" class="breadcrumb-item"> {{ data.Form_title }}</li>
                <li v-if ="data.step != 'one'" class="breadcrumb-item"> {{ data.form.Form_title }}</li>
            </ol>
        </nav>

        <div class="col-md-12">
            <button type="button" class="btn btn-color" v-if="data.step == 'one'">1 Form Information</button>
            <button type="button" class="btn btn-outline-secondary btn-inactive" v-if="data.step != 'one'">1 Form Information</button>
            <button type="button" class="btn btn-color"  v-if="data.step == 'two'">2 Build Form</button>
            <button type="button" class="btn btn-outline-secondary btn-inactive"  v-if="data.step != 'two'">2 Build Form</button>
            <button type="button" class="btn btn-color"   v-if="data.step == 'three'">3 Configuration</button>
            <button type="button" class="btn btn-outline-secondary btn-inactive"   v-if="data.step != 'three'">3 Configuration</button>


            <div>
                <br/>
                <div v-if="data.step == 'one'">
                    <Step_one :data="data" :errors="errors" :title="title" :link="link" :label="label" ></Step_one>
                </div>
                <div v-if="data.step == 'two'">
                    <Step_two :data="data" :errors="errors" :title="title" :link="link" :label="label" editMode="1"></Step_two>
                </div>
                <div v-if="data.step == 'three'">
                    <Step_three :data="data" :errors="errors" :title="title" :link="link" :label="label" editMode="1"></Step_three>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import Step_one from './Form/Step_one'
import Step_two from './Form/Step_two'
import Step_three from './Form/Step_three'

export default {
    components: {
        Alert,
        Step_one,
        Step_two,
        Step_three,
        datetime: Datetime
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
        }
    },

    created () {

    },
    methods: {

    }
}
</script>
