<template>
    <div class="page-wrapper user-color">

        <!-- Navbar top Start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>{{data.form.Form_title}} Data</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
<!--                        <a  :href="query.from == 'task' ? route(link) : route('form.response.show',data.form_id)"-->
<!--                            :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-angle-left">-->

<!--                        </i> {{ query.from == 'task' ? "Assignment List " : data.form.Form_title }}</a>-->
                        <a :href=" route('submissionData',data.id)" class="btn btn-primary btn-sm cls rg-top-btn">
                            <i class="fa fa-angle-left"></i> Go Back
                        </a>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar top End-->

        <nav aria-label="Page breadcrumb">
            <ol class="breadcrumb padding-top">
                <li class="breadcrumb-item" aria-current="page">Main</li>
                <li class="breadcrumb-item">{{label}}</li>
                <li class="breadcrumb-item">{{title}}</li>
                <li class="breadcrumb-item"> {{data.form.Form_title}}</li>
            </ol>
        </nav>


<!--        <slot name="header"></slot>-->

        <div class="register-form">
            <div class="col-lg-8 offset-lg-2 from-wrapper">
                <form>
                    <div v-for="(field,index) in orderedResponse" class="form-group">
                        <div v-if="field.field_type == 'textarea'">
                            <label :for="field.field_name" > <b> {{field.field_label}} </b>  </label>
                            <textarea :required="field.field_is_required == '1' ? true : false" class="form-control" :name="field.field_name"  :id="field.field_name" cols="20" rows="10" v-model="field.response_value"></textarea>
                        </div>
                        <div v-else-if="field.field_type == 'dropdown'">
                            <label :for="field.field_name" > <b> {{field.field_label}} </b></label>
                            <select :id="field.field_name" v-model="field.response_value">
                                <option v-for="option in field.options" :value="option.option_title">{{ option.option_title }}</option>
                            </select>
                        </div>
                        <div v-else-if="field.field_type == 'multiselect'">
                            <label :for="field.field_name" > <b> {{field.field_label}} </b> </label>
                            <div v-for="option in checkValue(field.options,response_valueArray)">
                                <input type="checkbox" :checked="option.check" :id="option.option_title" :name="option.option_title" :value="option.option_value"  @click="getSelectedValue(option.option_title)"/>
                                <label :for="option.option_title"> {{option.option_title}}</label><br>
                            </div>
                        </div>

                        <div v-else-if="field.field_type == 'checkbox'">
                            <input type="checkbox" name="check" v-model="field.response_value">
                            <label for="check"> {{field.field_label}}</label><br>
                        </div>

                        <div v-else-if="field.field_type == 'currency'">
                            <label for="label"> <b>  {{ field.field_label  }} </b></label>
                            <div class="row">
                                <div class="col-md-10" style="padding-right:0px;">
                                    <input class="form-control" type="text" :id="field.field_name" v-model="field.response_value">
                                </div>
                                <div class="col-md-2" style="padding-left:10px;">
                                    <span>NZD</span>
                                </div>
                            </div>
                        </div>
                        <div v-else-if="field.field_type == 'heading'">
                            <h4 style="font-size:20px; font-weight: bold;">{{field.field_label}}</h4>
                            <input type="hidden" v-model="field.response_value">
                        </div>
                        <div v-else-if="field.field_type == 'infobox'">
                            <h4 style="font-size:20px; font-weight: bold;">{{field.field_label}}</h4>
                            <p>{{field.field_default_value}} dddddd</p>
                            <input type="hidden" v-model="field.response_value">
                        </div>

                        <div v-else-if="field.field_type == 'fileupload'">
                            <label :for="field.field_name" > <b> {{field.field_label}} </b>  </label>
                            <input :name="field.field_name" :id="field.field_name"  @change="selectFile" @click="activeFileUpload(field)" class="form-control" type="file">
                            <a v-if="field.response_value" :href="field.response_value" target="_blank">View File</a>

                        </div>
                        <div v-else>
                            <label :for="field.field_name" > <b> {{field.field_label}} </b>  </label>
                            <input :name="field.field_name" :id="field.field_name" class="form-control" :type="field.field_type" v-model="field.response_value">
                        </div>
                    </div>
                    <div class="m-t-20 text-center">
                        <button
                            type="button"
                            class="save_role"
                            wire:click.prevent="store()"
                            @click="save()"
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
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'

import {HTTP} from '@/utils/http-common'
export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['data','title','flash','errors','link','label'],
    data() {
        return {
            active_option: {},
            query: {},
            multiSelectedValue:[],
            response_valueArray:[]
        }
    },
    created(){
        // console.log(this.data.fields)
        let response_valueArray = this.response_valueArray
        let field_option_filtered =[]
        this.data.fields.forEach(function(field) {
            if (field.field_type == 'multiselect'){
                // console.log(field.options)
                response_valueArray = field['response_value'].split(",")
                field['response_value'] = response_valueArray


                response_valueArray.forEach(function(field_option_check) {
                    const field_exists = field.options.find(option => option.option_title === field_option_check)
                    if (field_exists) {
                        field_option_filtered.push(field_option_check)
                    }
                });

                field['response_value'] = field_option_filtered
                // console.log( field_option_filtered)
            }

        });

        this.response_valueArray = field_option_filtered
        // console.log(this.response_valueArray)
    },
    computed: {
        orderedResponse: function () {
            return _.orderBy(this.data.fields, 'id')
        }
    },
    mounted() {
        if (!_.isEmpty(this.data.query)) {
            this.query = this.data.query
        }
    },
    methods: {
        checkValue(field_options,response_valueArray){

            response_valueArray.forEach(function(options_value) {
                // const exists = field_options.find(option => option.option_title === options_value)
                field_options.forEach(function(option) {
                    if (option.option_title == options_value){
                        option['check'] = true
                    }
                });
            });

            field_options.forEach(function(option_check) {
                if(option_check.hasOwnProperty('check') == false){
                    option_check['check'] = false
                }
            });

            //
            // console.log(response_valueArray)
            // console.log(field_options)

            return field_options
        },
        getSelectedValue(value){
            // let multiSelectedValue = this.multiSelectedValue

            let multiSelectedValue  = this.response_valueArray

            if (multiSelectedValue.length == 0) {
                multiSelectedValue.push(value);
            }
            else {
                const existing = multiSelectedValue.find(a => a === value)
                if (!existing) {
                    multiSelectedValue.push(value)
                }else {
                    let index = multiSelectedValue.indexOf(existing);
                    multiSelectedValue.splice(index, 1)
                }

            }

            this.data.fields.forEach(function(field) {
                if (field.field_type == 'multiselect'){
                    field['response_value'] = multiSelectedValue
                }

            });


        },
        activeFileUpload(option) {
            this.active_option = option;
        },
        selectFile(event) {
            this.disable_submit = true
            let photo = event.target.files[0];
            const data = new FormData();
            data.append('attachment', photo);
            HTTP.post('/form/file-upload', data)
                .then((response)=>{
                    if (response.data['url']){
                        this.active_option.response_value = response.data['url'];
                        console.log(this.form)
                    }
                    this.disable_submit = false;
                })
        },
        save: function () {
            this.$inertia.post('/form/response/'+this.data.id+'/updateData', this.data)
        }
    }
}
</script>
