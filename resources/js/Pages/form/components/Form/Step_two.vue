<template>
    <form>
        <div class="row justify-content-left">
            <div class="col-sm-3 card-box" style="margin:20px; border-radius:5px;">
                <div class="row justify-content-center">
                    <div class="col-md-10" style="text-align: left;margin-bottom: 15px;font-size: 20px;font-weight: bold;">
                        Input Fields
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddHeading()"><i class="fas fa-heading"></i> Heading </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddText()"><i class="fas fa-text-width"></i> Text </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddNumber()"><i class="fas fa-list-ol"></i> Number </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddDate()"><i class="far fa-calendar-alt"></i> Date </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddTextArea()"><i class="far fa-keyboard"></i> TextArea </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddTime()"><i class="far fa-clock"></i> Time </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddCurrency()"><i class="fas fa-coins"></i> Currency </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddDropDown()"><i class="fas fa-caret-down"></i> DropDown </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddMultiSelect()"><i class="far fa-check-square"></i> Multi Select </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddFileUpload()"><i class="fas fa-upload"></i> File Upload </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddCheckBox()"><i class="far fa-check-square"></i> Check Box </a>
                    </div>
                    <div class="col-md-5">
                        <a class="btn btn-primary submit-btn" style="border-radius:5px; font-size:10px; min-width:100px; margin-bottom:15px; padding: 5px 10px;" href="#" @click="AddInfoBox()"><i class="fas fa-info"></i>Info Box </a>
                    </div>
                </div>
            </div>

            <div class="col-sm-4 card-box" style="margin:20px; border-radius:5px;">
                <div class="form-group">
                    <input type="text" class="form-control" value="" v-model="form.Form_title">
                    <input type="text" class="form-control" value="" v-model="form.description">
                    <input type="hidden" class="form-control" value="" v-model="form.category_id">
                    <input type="hidden" class="form-control" value="" v-model="form.organization_id">
                    <input type="hidden" class="form-control" value="" v-model="form.from_department_id">
                </div>
                <draggable v-model="form.fields"  @start="drag=true" @end="drag=false">
                    <div v-for="(field, index) in form.fields" class="form-group" :key="index">
                        <div @click="MakeActive(field)" >
                            <div  v-if="field.field_type == 'textarea'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <textarea class="form-control" v-if="field.field_type == 'textarea'" name="" id="" cols="20" rows="10" readonly></textarea>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div  v-if="field.field_type == 'infobox'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <textarea class="form-control" v-if="field.field_type == 'infobox'" name="" id="" cols="20" rows="10" readonly>{{ field.field_default_value }}</textarea>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type == 'date'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <input class="form-control" type="date" id="inputs" readonly>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div  v-else-if="field.field_type == 'number'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <input class="form-control" type="number" id="inputs" readonly>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type == 'time'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <input class="form-control" type="time" id="inputs" readonly>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type == 'heading'">
                                <h4>{{field.field_label}}</h4>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type == 'currency'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <div class="row">
                                    <div class="col-md-10" style="padding-right:0px;">
                                        <input class="form-control" type="text" id="inputs" readonly>
                                    </div>
                                    <div class="col-md-2" style="padding-left:10px;">
                                        <span>NZD</span>
                                    </div>
                                </div>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type=='dropdown'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <select id="label">
                                    <option v-for="option in field.options" value="volvo">{{ option.option_title }}</option>
                                </select>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else-if="field.field_type=='multiselect'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label><br>
                                <div v-for="option in field.options">
                                    <input type="checkbox" id="option[]" name="option[]">
                                    <label for="option[]"> {{option.option_title}}</label><br>
                                </div>
                            </div>
                            <div v-else-if="field.field_type=='checkbox'">
                                <div>
                                    <input type="checkbox" id="option" name="option">
                                    <label for="option"> {{field.field_label}}</label><br>
                                </div>
                            </div>
                            <div v-else-if="field.field_type=='fileupload'">
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <input class="form-control" type="file" id="inputs" readonly>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                            <div v-else >
                                <label for="label"> <b>{{ field.field_label  }}</b> </label>
                                <input class="form-control" type="text" id="inputs" readonly>
                                <input type="hidden" value="" id="" v-model="field.field_type">
                            </div>
                        </div>
                    </div>

                </draggable>
            </div>
            <div class="col-sm-3 card-box" style="margin:20px; border-radius:5px;">
                <div v-if = "active_field" class="form-group options" >

                    <div v-if = "active_field.field_type == 'heading'">
                        <label for="label"> <b>Heading Text</b> </label>
                        <input class="form-control" type="text" id="inputs" value="" v-model="active_field.field_label">
                    </div>
                    <div v-else-if="active_field.field_type == 'multiselect'">
                        <label for="label"> <b>Field Label</b> </label>
                        <input class="form-control" type="text" id="inputs" value="" v-model="active_field.field_label">

                        <label for="instruction"> <b>Instruction</b> </label>
                        <input class="form-control" type="text" id="instruction" value="" v-model="active_field.field_instruction">

                        <div>
                            <label for="optionname"> <b>Option Name</b> </label>
                            <input class="form-control" id="optionname" type="text" value="" v-model="field_options.option_title" >
                            <div class="text-danger" v-if="error_option_title != 0">Field is required! </div>

                            <label for="optionvalue"> <b>Option Value</b> </label>
                            <input class="form-control" id="optionvalue" type="text" value="" v-model="field_options.option_value" >
                            <div class="text-danger" v-if="error_option_value != 0">Field is required! </div>

                            <a style="min-width: 30px;padding: 2px 5px;font-size: 15px;border-radius: 5px; color:#fff;margin: 10px auto" class="btn btn-primary submit-btn" @click="AddOption()">Add+</a>
                            <ul v-for=" (opt, index) in active_field.options">
                                <div class="row">
                                    <div class="col-md-11">
                                        <input class="form-control" type="text" v-model="opt.option_title">
                                    </div>
                                    <div class="col-md-1" style="padding-left: 0px;padding-top: 7px;">
                                        <a style="padding: 5px 9px;border: 1px solid red;border-radius: 50%;color: red;" href="#" @click="RemoveOptions(index,opt)" > X </a>
                                    </div>
                                </div>
                            </ul>
                        </div>

                        <label for="default"> <b>Initial Value</b> </label>
                        <input class="form-control" type="text" id="default" value="" v-model="active_field.field_default_value">
                        <input type="hidden" value="" id="" v-model="active_field.field_type">
                        <p>Validation</p>
                        <input type="radio" id="male"  value="1" v-model="active_field.field_is_required">
                        <label for="male"> <b>Mandatory</b> </label><br>
                        <input type="radio" id="female"  value="0" v-model="active_field.field_is_required">
                        <label for="female"> <b>Not Mandatory</b> </label><br>
                    </div>
                    <div v-else-if="active_field.field_type == 'dropdown'">
                        <label for="label"> <b>Field Label</b> </label>
                        <input class="form-control" type="text" id="inputs" value="" v-model="active_field.field_label">

                        <label for="instruction"> <b>Instruction</b> </label>
                        <input class="form-control" type="text" id="instruction" value="" v-model="active_field.field_instruction">

                        <div>
                            <label for="optionname"> <b>Option Name</b> </label>
                            <input class="form-control" id="optionname" type="text" value="" v-model="field_options.option_title" >
                            <div class="text-danger" v-if="error_option_title != 0">Field is required! </div>

                            <label for="optionvalue"> <b>Option Value</b> </label>
                            <input class="form-control" id="optionvalue" type="text" value="" v-model="field_options.option_value" >
                            <div class="text-danger" v-if="error_option_value != 0">Field is required! </div>

                            <a  style="min-width: 30px;padding: 2px 5px;font-size: 15px; color:#fff;border-radius: 5px;margin: 10px auto" class="btn btn-primary submit-btn" @click="AddOption2()">Add+</a>
                            <ul v-for=" (opt, index) in active_field.options">
                                <div class="row">
                                    <div class="col-md-11">
                                        <input class="form-control" type="text" v-model="opt.option_title">
                                    </div>
                                    <div class="col-md-1" style="padding-left: 0px;padding-top: 7px;">
                                        <a style="padding: 5px 9px;border: 1px solid red;border-radius: 50%;color: red;" href="#" @click="RemoveOptions(index,opt)" > X </a>
                                    </div>
                                </div>
                            </ul>
                        </div>

                        <label for="default"> <b>Initial Value</b> </label>
                        <input class="form-control" type="text" id="default" value="" v-model="active_field.field_default_value">
                        <input type="hidden" value="" id="" v-model="active_field.field_type">
                        <p>Validation</p>
                        <input type="radio" id="male"  value="1" v-model="active_field.field_is_required">
                        <label for="male"> <b>Mandatory</b> </label><br>
                        <input type="radio" id="female"  value="0" v-model="active_field.field_is_required">
                        <label for="female"> <b>Not Mandatory</b> </label><br>
                    </div>
                    <div v-else>
                        <label for="label"> <b>Field Label</b> </label>
                        <input class="form-control" type="text" id="inputs" value="" v-model="active_field.field_label">
                        <label for="name"> <b>Field Name</b> </label>
                        <input class="form-control" type="text" id="name" value="asdf" v-model="active_field.option_title" readonly>
                        <label for="instruction"> <b>Instructions </b> </label>
                        <input class="form-control" type="text" id="instruction" value="" v-model="active_field.field_instruction">
                        <label for="default"> <b>Initial Value</b> </label>
                        <input class="form-control" type="text" id="default" value="" v-model="active_field.field_default_value">
                        <input type="hidden" value="" id="" v-model="active_field.field_type">
                        <p>Validation</p>
                        <input type="radio" id="male"  value="1" v-model="active_field.field_is_required">
                        <label for="male"> <b>Mandatory</b> </label><br>
                        <input type="radio" id="female"  value="0" v-model="active_field.field_is_required">
                        <label for="female"> <b>Not Mandatory</b> </label><br>
                    </div>
                    <br/>
                    <button class="btn btn-danger"  @click="deleteField(active_field)">Delete</button>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-11">
                <div class="m-t-20 text-center">
                    <button
                        style="background-color: orange"
                        type="button"
                        class="form-submit-btn ml-10  pull-right "
                        wire:click.prevent="store()"
                        @click="update(form, 'preview')"
                        >
                        Preview
                    </button>
                    <button
                       type="button"
                       class="form-submit-btn  pull-right  ml-10"
                       wire:click.prevent="store()"
                       @click="update(form, 'next')"
                       >
                       Next
                   </button>

                    <button
                        style="background-color: green"
                        type="button"
                        class="form-submit-btn  ml-10  pull-right "
                        wire:click.prevent="store()"
                        @click="update(form, 'save')"
                    >
                        Save & Exit
                    </button>


                </div>
            </div>
        </div>

    </form>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";
import draggable from 'vuedraggable'
import {HTTP} from '@/utils/http-common'

export default {
    components: {
        Alert,
        draggable,
        datetime: Datetime
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            drag: false,
            photo: null,
            active_field:null,
            field_options:{},
            error_option_value: 0,
            error_option_title: 0,
            form: {
                id: this.data.form.id,
                Form_title: this.data.form.Form_title,
                description: this.data.form.description,
                category_id: this.data.form.category_id,
                from_department_id: this.data.form.from_department_id,
                organization_id: this.data.form.organization_id,
                fields: []

            }
        }
    },

    created () {
        if (this.editMode) {
            this.form = this.data.form
            this.form['fields'] = this.data.fields
        }
    },
    methods: {
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        MakeActive: function(field){
            this.active_field = field
        },
        AddOption: function(){
            let error_option_title = 0;
            let error_option_value = 0;
            let error_option1 = 0;
            let error_option2 = 0;

            if(this.field_options.hasOwnProperty('option_value') == true){

                if (this.field_options.option_value == ''){
                    error_option_value++
                    error_option1++
                }
            }else {
                error_option_value++
                error_option1++
            }

            if(this.field_options.hasOwnProperty('option_title') == true){

                if (this.field_options.option_title == ''){
                    error_option_title++
                    error_option2++
                }
            }else {
                error_option_title++
                error_option2++
            }

            this.error_option_title = error_option_title
            this.error_option_value = error_option_value

            if (error_option2 == 0 && error_option1 == 0){
                this.active_field.options.push(this.field_options)
                this.field_options = {}
            }

        },
        AddOption2: function(){
            let error_option_title = 0;
            let error_option_value = 0;
            let error_option1 = 0;
            let error_option2 = 0;

            if(this.field_options.hasOwnProperty('option_value') == true){

                if (this.field_options.option_value == ''){
                    error_option_value++
                    error_option1++
                }
            }else {
                error_option_value++
                error_option1++
            }

            if(this.field_options.hasOwnProperty('option_title') == true){

                if (this.field_options.option_title == ''){
                    error_option_title++
                    error_option2++
                }
            }else {
                error_option_title++
                error_option2++
            }

            this.error_option_title = error_option_title
            this.error_option_value = error_option_value

            if (error_option2 == 0 && error_option1 == 0){
                this.active_field.options.push(this.field_options)
                this.field_options = {}
            }

        },
        AddHeading: function(){
            let field = {
                field_type:'heading',
                field_label:'Heading',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        RemoveOptions:function(index,option){
            console.log(option.id)
            if(option.id){
                HTTP.delete('/forms/' + option.id +'/removeFieldOption');
            }
            this.active_field.options.splice(index, 1)
        },
        AddFileUpload: function(){
            let field = {
                field_type:'fileupload',
                field_label:'File Upload',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push( field)
            this.active_field = field
        },
        AddInfoBox: function(){
            let field = {
                field_type:'infobox',
                field_label:'Info Box',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push( field)
            this.active_field = field
        },
        AddCheckBox: function(){
            let field = {
                field_type:'checkbox',
                field_label:'Check Box',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push( field)
            this.active_field = field
        },
        AddMultiSelect: function(){
            let field = {
                field_type:'multiselect',
                field_label:'multiselect',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0',
                options: [{
                    option_title:'option1',
                    option_value:'option1'
                }]
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddText: function(){
            let field = {
                field_type:'text',
                field_label:'Text',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0',
                name: ''
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddDropDown: function(){
            let field = {
                field_type:'dropdown',
                field_label:'dropdown',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0',
                options: [{
                    option_title:'option1',
                    option_value:'option1',
                }]
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddNumber: function(){
            let field = {
                field_type:'number',
                field_label:'Number',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddTime: function(){
            let field = {
                field_type:'time',
                field_label:'Time',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddCurrency: function(){
            let field = {
                field_type:'currency',
                field_label:'US Dollar',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field =  field
        },
        AddDate: function(){
            let field = {
                field_type:'date',
                field_label:'Date',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        AddTextArea: function(){
            let field = {
                field_type:'textarea',
                field_label:'Text Area',
                field_instruction: '',
                field_default_value: '',
                field_is_required: '0'
            }
            this.form.fields.push(field)
            this.active_field = field
        },
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            var data = new FormData()
            data.append('name', params.name || '')
            data.append('fields[]', params.fields || '')

            this.$inertia.post('/forms', params)
        },

        update: function (params, type) {
            params['type'] = type;
            this.$inertia.put('/forms/' + params.id, params)

            if (params['type'] == 'preview'){
                window.open('/form/response/' + params.slug, '_blank')
            }

        },


        deleteField: function (field) {
            if(field.id){
                HTTP.delete('/forms/' + field.id +'/removeField');
            }

            let index = this.form.fields.indexOf(field);
            this.form.fields.splice(index, 1)
            this.active_field = null;
        }
    }
}
</script>
