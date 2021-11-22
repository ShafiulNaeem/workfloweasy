<template>
    <div class="patient-create">
        <slot name="header"></slot>

        <div class="row justify-content-center">
            <div class="col-lg-6 card-box">
              <h2>{{data.Form_title}}</h2>
                    <form>
                      <div v-for="(field,index) in data.fields" class="form-group">
                        <div v-if="field.field_type == 'textarea'">
                          <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" :for="field.field_name" > <b> {{field.field_label}} </b><span v-show="field.field_is_required == 1" class="text-red">*</span> </label>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <textarea :required="field.field_is_required == '1' ? true : false" class="form-control" :name="field.field_name"  :id="field.field_name" cols="20" rows="10" v-model="field.response_value"></textarea>
                            <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                        <div v-else-if="field.field_type == 'dropdown'">
                          <label :for="field.field_name" > <b> {{field.field_label}} </b><span v-show="field.field_is_required == 1" class="text-red">*</span> </label>
                          <select :id="field.field_name" v-model="field.response_value">
                              <option v-for="option in field.options" :value="option.option_title">{{ option.option_title }}</option>
                          </select>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                        <div v-else-if="field.field_type == 'multiselect'">
                          <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" :for="field.field_name" > <b> {{field.field_label}} </b><span v-show="field.field_is_required == 1" class="text-red">*</span></label>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <div v-for="option in field.options">
                            <input type="checkbox" :checked="check" :id="option.option_title" :name="option.option_title" :value="option.option_value"  @click="getSelectedValue(option.option_title)"/>
                            <label :for="option.option_title" > {{option.option_title}}</label><br>
                          </div>
                            <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                        <div v-else-if="field.field_type == 'checkbox'">
                            <input type="checkbox" name="check" :value="1" v-model="field.response_value">
                            <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" for="check"> {{field.field_label}} <span v-show="field.field_is_required == 1" class="text-red">*</span></label><br>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                        <div v-else-if="field.field_type == 'currency'">
                          <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" for="label"> <b>  {{ field.field_label  }} </b><span v-show="field.field_is_required == 1" class="text-red">*</span></label>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <div class="row">
                            <div class="col-md-10" style="padding-right:0px;">
                              <input class="form-control" type="text" :id="field.field_name" v-model="field.response_value">
                            </div>
                            <div class="col-md-2" style="padding-left:10px;">
                              <span>NZD</span>
                            </div>
                              <div style="padding-left: 16px;" class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                          </div>
                        </div>

                        <div v-else-if="field.field_type == 'heading'">
                          <h4 style="font-size:20px; font-weight: bold;">{{field.field_label}}</h4>
                          <input type="hidden" v-model="field.response_value">
                        </div>

                        <div v-else-if="field.field_type == 'infobox'">
                          <h4 style="font-size:20px; font-weight: bold;">{{field.field_label}}</h4>
                          <p>{{field.field_default_value}}</p>
                            <input type="hidden" v-model="field.response_value">
                        </div>

                        <div v-else-if="field.field_type == 'fileupload'">
                          <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" :for="field.field_name" > <b> {{field.field_label}} </b><span v-show="field.field_is_required == 1" class="text-red">*</span>  </label>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                            <input :name="field.field_name" :id="field.field_name"  @change="selectFile" @click="activeFileUpload(field)" class="form-control" type="file">
                            <a v-if="field.response_value" :href="field.response_value" target="_blank">View File</a>
                            <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                        <div v-else>
                          <label :style="field.field_instruction != null?'margin-bottom: -.5rem':''" :for="field.field_name" > <b> {{field.field_label}} </b><span v-show="field.field_is_required == 1" class="text-red">*</span> </label>
                            <div v-show="field.field_instruction != null" >{{field.field_instruction}}</div>
                          <input :name="field.field_name" :id="field.field_name" class="form-control" :type="field.field_type" v-model="field.response_value">
                          <div class="text-danger" v-if="field.id == error_field_id[field.id]">Field is required! Please Insert Your Data.</div>
                        </div>

                      </div>
                        <div class="m-t-20 text-center">
                            <vue-recaptcha sitekey="6Lf-vD4aAAAAALi5K59b6Per2yPOCZhLBn-A4kBn">
                                <button
                                    type="button"
                                    class="btn btn-primary cls"
                                    wire:click.prevent="store()"
                                    v-show="editMode"
                                    :disabled="disable_submit"
                                    @click="save(form)"
                                >
                                    Submit
                                </button>
                            </vue-recaptcha>
                        </div>
                    </form>
                    <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="formPassModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content " >
      <div class="modal-header justify-content-center">
        <h6 class="font-weight-bold text-secondary">This form is protected by password</h6>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Password</label>
            <input type="text" class="form-control" v-model="form.pass" id="recipient-name" placeholder="Type Passowrd...">
             <span class="text-danger mt-2" v-if="error">Your Pasoword incorrect, please try again!</span>
          </div>
        </form>
      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button @click="checkPass()" type="button" class="btn btn-primary btn-lg" >Verify</button>
      </div>
    </div>
  </div>
</div>
</div>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import VueRecaptcha from 'vue-recaptcha';
import {HTTP} from '@/utils/http-common';
import axios from "axios";

export default {
    components: {
        Alert,
        VueRecaptcha,
        datetime: Datetime
    },
    props: ['data', 'editMode', 'errors'],
    data () {
        return {
            active_option: {},
            field_options: {},
            disable_submit: false,
            error:false,
            check:false,
            error_field_id:[],
            multiSelectedValue:[],
            form: {
                id: undefined,
                Form_title: this.data.Form_title,
                description: this.data.description,
                category_id: this.data.category_id,
                fields: [],
                pass:null,
                form_setting_id: this.data.form_setting_id,

            }
        }
    },

    created () {
        if (this.editMode) {
            this.form = this.data
            this.openModal
        }
    },
    mounted(){
     if (this.data.is_password) {
       $(window).on('load',function(){
        $('#formPassModal').modal('show');
    });
     }
    // var url = window.location.pathname;
    //  var newUrl = new URL('/success', url);
    // var newUrl = url + '/success';
    //   alert(newUrl);



    },
    methods: {
        getSelectedValue(value){
            let multiSelectedValue = this.multiSelectedValue

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
        errMsg () {
          this.form.message = true;
        },
      checkPass(){
            var data = new FormData()
            data.append('password', this.form.pass || '')
            data.append('id', this.form.form_setting_id || '')
            axios.post('/form-responses-protect', data)
              .then((res)=>{
                    if(res.data.status == 200){
                      $('#formPassModal').modal('hide');
                    }else{
                      this.error=true
                    }
              })

        // $('#exampleModal').modal('hide')
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
                        // console.log(this.form)
                    }
                    this.disable_submit = false;
                })
        },
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('fields[]', params.fields || '')


            let error_field = 0
            let error_field_id = []
            params.fields.forEach(function(data) {

                if (data.field_type != 'heading' && data.field_type != 'infobox'){
                    if (data.field_is_required == 1){
                        if(data.hasOwnProperty('response_value') == true){

                            if (data.response_value == ''){
                                let id = data.id
                                error_field_id[id] = data.id
                                error_field++
                            }
                        }else {
                            let id = data.id
                            error_field_id[id] = data.id
                            error_field++
                        }
                    }

                }
            });
             this.error_field_id = error_field_id
            params['iframe'] = false

            if(error_field == 0 ){
                this.$inertia.post('/form-responses', params)
            }

        },

        update: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('fields[]', params.fields || '')
            data.append('_method', 'PUT')

            this.$inertia.put('/forms/' + params.id, params)
        }
    }
}
</script>
