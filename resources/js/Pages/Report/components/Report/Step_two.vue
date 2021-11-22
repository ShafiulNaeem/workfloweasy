<template>
    <form action="">
        <div>
            <div class="col-md-11 card-box">
                <div class="row">
                    <div class="col-md-6">
                        <div class="report-title">
                            <h4>Data Representation</h4>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="report-label" for="name">Data Columns:</label>
                                    <select size="15" name="" v-model="add_field"  class="form-control select">
                                        <option v-for="form_field in data.form_fields"  :value="form_field" :key="form_field.id">{{form_field.field_name}}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group" style="padding: 10px;">
                                    <button
                                        type="button"
                                        class="report-add"
                                        wire:click.prevent="store()"
                                        @click="selectField(add_field)"
                                    >
                                        ADD
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="report-label" for="name">Selected Columns:</label>
                                    <select size="15" name="" v-model="remove_field" class="form-control select">
                                        <option v-for="(form_field,index) in selectedField" :value="form_field" :key="form_field.id">{{form_field.field_name}}</option>
                                    </select>
                                    <div class="text-danger" v-if="error_selectedField == 1">The Selected Columns field is required.</div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group" style="padding: 10px;">
                                    <button style="margin-top: 120px; border: none; background: none;"
                                            type="button"
                                            @click="remove(remove_field)"
                                    >
                                        <i class="fas fa-window-close" style="color: red;"></i>
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="report-title">
                            <h4>Data Analysis By</h4>
                        </div>
                        <div class="row report-body">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="report-label" for="name">Total</label>
                                    <input class="form-control checkbox_styl1" v-model="form.total" type="checkbox" />

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="report-label" for="name">Lowest</label>
                                    <input class="form-control checkbox_style" v-model="form.lowest" type="checkbox" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="report-label " for="name">Highest</label>
                                    <input class="form-control checkbox_style" v-model="form.highest" type="checkbox" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="report-label" for="name">Average</label>
                                    <input class="form-control checkbox_style" v-model="form.average" type="checkbox" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-11">
                    <div class="m-t-20 text-center">
                        <button
                            type="button"
                            class="form-submit-btn ml-10 pull-right "
                            wire:click.prevent="store()"
                            @click="save(form)"
                        >
                            Next
                        </button>
<!--                        <button-->
<!--                            style="background-color:#F39C12"-->
<!--                            type="button"-->
<!--                            class="form-submit-btn  pull-right ml-10"-->
<!--                            wire:click.prevent="store()"-->
<!--                            @click="cancel()"-->
<!--                        >-->
<!--                            Go Back-->
<!--                        </button>-->
                        <button
                            style="background-color: red"
                            type="button"
                            class="form-submit-btn  pull-right ml-10"
                            wire:click.prevent="store()"
                            @click="cancel()"
                        >
                            Go Back
                        </button>


                    </div>
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
            add_field_id:null,
            add_field:{},
            remove_field:null,
            selectedField:[],
            error_selectedField:0,
            form: {
                id: undefined,
                report_id: this.data.report.id,
                form_id:this.data.report.form_id,
                // report_slug: this.data.report.slug,
                total:false,
                lowest:false,
                highest:false,
                average:false,

            }
        }
    },

    created () {
        if (this.data.edit == 'yes'){
            this.selectedField = this.data.selected_fields
            this.form.total = this.data.reportData.total
            this.form.lowest = this.data.reportData.lowest
            this.form.highest = this.data.reportData.highest
            this.form.average = this.data.reportData.average
        }
    },
    methods: {
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        selectField: function(field){

            if (field.hasOwnProperty('id') == true){
                this.selectedField.push({
                    id: field.id,
                    field_name: field.field_name
                })

                let index = this.data.form_fields.indexOf(field);
                this.data.form_fields.splice(index, 1)
            }
            this.add_field = {}

        },
        remove(remove_field){

            if (remove_field.hasOwnProperty('id') == true){
                if (!confirm('Are you sure want to remove?')) return;

                let index = this.selectedField.indexOf(remove_field);
                this.selectedField.splice(index, 1);

                this.data.form_fields.push({
                    id: this.remove_field.id,
                    field_name: this.remove_field.field_name
                })

            }
            this.remove_field = {}
        },

        save: function (params) {

            if (this.selectedField.length == 0){
                this.error_selectedField = 1
            }else {
                let form_fields = [];
                this.selectedField.forEach(function(data) {
                    form_fields.push(data['id'])
                });
                params['form_field_id'] = form_fields;
                this.$inertia.post('/reports/generate/dataRepresentation/'+ this.data.report.slug +'/data-store', params)
            }
        },
         cancel: function () {
            this.$inertia.get('/reports/generate/'+this.data.report.slug)
        },

    }
}
</script>
