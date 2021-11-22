<template>
    <form action="">
        <div class="col-md-12">
            <div class="row">

                <div :class="reportType == 'COMPARE'?'col-md-5 card-box' :'col-md-11 card-box' ">
                    <div :class="reportType != 'COMPARE'?'col-md-6' :'' ">
                    <div class="report-title">
                        <h4>Data Filter</h4>
                    </div>
                    <div class="row" style="padding-left: 17px;">
                        <div class="col-md-12" style="margin-left: -16px;">
                            <label>Standard Date Filter</label>
                        </div>
                        <div class="col-md-4" style="padding:0px;">
                            <div class="form-group" >
                                <Select2 v-model="form.dateField" :options="dateField" placeholder="Select option"/>
                                 <div class="text-danger" v-if="errors.dateField">Field is required.</div>
                            </div>

                        </div>
                        <!-- <div class="col-md-2"  style="padding:0px;">
                            <div class="form-group">
                                <Select2  v-model="form.custom" :options="custom"/>
                            </div>
                        </div> -->

                        <div  class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <datetime style="float: left;" v-model="form.startDate"
                                          type="date"
                                          wrapper-class="my-wrapper-class"
                                          input-class="my-input-class datetime_style"
                                          placeholder="Start date"
                                ></datetime>
                                <div class="text-danger" v-if="errors.startDate">required.</div>
                            </div>
                        </div>
                        <div  class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <datetime style="float: left;" v-model="form.endDate"
                                          type="date"
                                          wrapper-class="my-wrapper-class"
                                          input-class="my-input-class datetime_style"
                                          placeholder="End date"
                                ></datetime>
                                <div class="text-danger" v-if="errors.endDate">required.</div>
                            </div>
                        </div>

                    </div>
<!--                    ***************_start select Days for filter one _****************-->
<!--                    <div  class="col-md-12">-->
<!--                       <div class="row">-->
<!--                           <div class="col-md-4"  style="padding:0px;">-->
<!--                               <div class="form-group" >-->
<!--                                   <select name="LeaveType" @change="onChange($event, 1)" class="form-control"  style="width:135px">-->
<!--                                       <option >Select date</option>-->
<!--                                       <option value="7">Last 7 Days</option>-->
<!--                                       <option value="15">Last 15 Days</option>-->
<!--                                       <option value="custom">Custom Days</option>-->
<!--                                   </select>-->
<!--                               </div>-->

<!--                           </div>-->
<!--                           <div v-if="selectDays == true" class="col-md-4"  style="padding:0px;">-->
<!--                               <div class="form-group">-->
<!--                                   <datetime style="float: left;" v-model="form.startDate"-->
<!--                                             type="date"-->
<!--                                             wrapper-class="my-wrapper-class"-->
<!--                                             input-class="my-input-class datetime_style"-->
<!--                                             placeholder="Start date"-->
<!--                                   ></datetime>-->
<!--                                   <div class="text-danger" v-if="errors.startDate">required.</div>-->
<!--                               </div>-->
<!--                           </div>-->
<!--                           <div v-if="selectDays == true" class="col-md-4"  style="padding:0px;">-->
<!--                               <div class="form-group">-->
<!--                                   <datetime style="float: left;" v-model="form.endDate"-->
<!--                                             type="date"-->
<!--                                             wrapper-class="my-wrapper-class"-->
<!--                                             input-class="my-input-class datetime_style"-->
<!--                                             placeholder="End date"-->
<!--                                   ></datetime>-->
<!--                                   <div class="text-danger" v-if="errors.endDate">required.</div>-->
<!--                               </div>-->
<!--                           </div>-->
<!--                       </div>-->
<!--                    </div>-->
<!--                    ***************_ end select Days for filter two_****************-->
                    <div  class="row" style="padding-left: 17px;">
                        <div class="col-md-12" style="margin-left: -16px;">
                            <label>Advanced Data Filter</label>
                        </div>
                        <div class="col-md-4" style="padding:0px;">
                            <div class="form-group" >
                                <Select2 v-model="form.dataField" :options="dataField" placeholder="Select option"/>
                                <div class="text-danger" v-if="errors.dataField">Data field  required.</div>
                            </div>
                        </div>

                        <div class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <Select2  v-model="form.compare_op" :options="compare_op"  placeholder="Select option"/>
                                <div class="text-danger" v-if="errors.compare_op">required.</div>
                            </div>

                        </div>
                        <div class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <input  class="form-control" type="text" v-model="form.input" placeholder="Compare value">
                            </div>
                            <div class="text-danger" v-if="errors.input">required.</div>

                        </div>


                    </div>
                    </div>
                </div>


 <!--  ******************_Start filter two_*******************-->
                <div v-if="reportType == 'COMPARE'" class="col-md-1 text-center" style="padding-top: 120px;">
                    <i class="fas fa-columns" style="font-size: 40px;"></i>
                    <b>COMPARE</b>
                </div>
                <div v-if="reportType == 'COMPARE' " class="col-md-5 card-box">
                    <div class="report-title">
                        <h4>Data Filter</h4>
                    </div>

                    <div class="row" style="padding-left: 17px;">
                        <div class="col-md-12" style="margin-left: -16px;">
                            <label>Standard Date Filter</label>
                        </div>
                        <div class="col-md-4" style="padding:0px;">
                            <div class="form-group" >
                                <Select2 v-model="form.dateField2" :options="dateField2"  placeholder="Select option"/>
                                <div class="text-danger " v-if="errors.dateField2">Field is required.</div>
                            </div>
                        </div>

                        <div   class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <datetime style="float: left;" v-model="form.startDate2"
                                          type="date"
                                          wrapper-class="my-wrapper-class "
                                          input-class="datetime_style date-icon"
                                          placeholder="Start date"
                                ></datetime>
                                <div class="text-danger" v-if="errors.startDate2">required.</div>
                            </div>
                        </div>
                        <div    class="col-md-4"  style="padding:0px;">

                            <div class="form-group">
                                <datetime   style="float: left;" v-model="form.endDate2"
                                          type="date"
                                          wrapper-class="my-wrapper-class"
                                            input-class="datetime_style date-icon"
                                            placeholder="End date"
                                ></datetime>
                                <div class="text-danger" v-if="errors.endDate2">required.</div>
                            </div>
                        </div>

                    </div>
<!--***************_start select Days for filter one _****************-->
<!--                    <div  class="col-md-12" >-->
<!--                        <div class="row">-->
<!--                            <div class="col-md-4"  style="padding:0px;">-->
<!--                                <div class="form-group" >-->
<!--                                    <select name="LeaveType" @change="onChange($event, 2)" class="form-control"  style="width: 135px">-->
<!--                                        <option >Select date</option>-->
<!--                                        <option value="7">Last 7 Days</option>-->
<!--                                        <option value="15">Last 15 Days</option>-->
<!--                                        <option value="custom">Custom Days</option>-->
<!--                                    </select>-->
<!--                                </div>-->

<!--                            </div>-->
<!--                            <div v-if="selectDaysTwo == true"  class="col-md-4"  style="padding:0px;">-->
<!--                                <div class="form-group">-->
<!--                                    <datetime style="float: left;" v-model="form.startDate2"-->
<!--                                              type="date"-->
<!--                                              wrapper-class="my-wrapper-class"-->
<!--                                              input-class="my-input-class datetime_style"-->
<!--                                              placeholder="Start date"-->
<!--                                    ></datetime>-->
<!--                                    <div class="text-danger" v-if="errors.startDate2">required.</div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                            <div v-if="selectDaysTwo == true"  class="col-md-4"  style="padding:0px;">-->
<!--                                <div class="form-group">-->

<!--                                    <datetime style="float: left;" v-model="form.endDate2"-->
<!--                                              type="date"-->
<!--                                              wrapper-class="my-wrapper-class"-->
<!--                                              input-class="my-input-class datetime_style"-->
<!--                                              placeholder="End date"-->
<!--                                    ></datetime>-->
<!--                                    <div class="text-danger" v-if="errors.endDate2">required.</div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
 <!--                    ***************_ end select Days for filter two_****************-->


                    <div class="row" style="padding-left: 17px;">
                        <div class="col-md-12" style="margin-left: -16px;">
                            <label>Advanced Data Filter</label>
                        </div>
                        <div class="col-md-4" style="padding:0px;">
                            <div class="form-group" >
                                <Select2 v-model="form.dataField2" :options="dataField2"  placeholder="Select option"/>
                                <div class="text-danger" v-if="errors.dataField2">required.</div>
                            </div>
                        </div>
                        <div class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                <Select2  v-model="form.compare_op2" :options="compare_op2" placeholder="Select option"/>
                                <div class="text-danger" v-if="errors.compare_op2">required.</div>
                            </div>
                        </div>
                        <div class="col-md-4"  style="padding:0px;">
                            <div class="form-group">
                                 <input  class="form-control" type="text" v-model="form.input2" placeholder="Compare value">
                            </div>
                             <div class="text-danger" v-if="errors.input2">required.</div>
                        </div>


                    </div>
<!--                 ******************_End Filter two_****************-->
                </div>
            </div>
            <div class="row">
                <div class="col-md-11">
                    <div class="m-t-20 text-center">
                        <button
                            v-if="actionBtn == 0"
                            type="button"
                            class="form-submit-btn ml-10 pull-right "
                            wire:click.prevent="store()"
                            @click="save(form)"
                        >
                            Next
                        </button>
                         <button
                            v-if="actionBtn == 1"
                            type="button"
                            class="form-submit-btn ml-10 pull-right "
                            wire:click.prevent="store()"
                            @click="save(form)"
                        >
                            Next
                        </button>
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
import Alert from '@/Pages/Component/Alert';
import { Datetime } from 'vue-datetime';
import 'vue-datetime/dist/vue-datetime.css';
import moment from "moment";
import draggable from 'vuedraggable';
import Select2 from 'v-select2-component';


export default {
    components: {
        Alert,
        draggable,
        datetime: Datetime,
        Select2,
        moment
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {

            isActive:true,
            oks: true,
            drag: false,
            photo: null,
            active_field:null,
            field_options:{},
            typeField:[],
            typeField2:[],
            typeFieldData:[],
            typeFieldData2:[],
            dateField:[
                {id:null, text: ''}
                ],
            dateField2:[
                {id:null, text: ''}
                ],
            dataField:[
                {id:null, text:''}
                ],
            dataField2:[{id:null, text: ''}],
            compare_op:[
                {id:'=', text: 'Equal'},
                {id: '!=', text: 'Not equal'},
                {id:'>', text: 'Greater than'},
                {id:'<', text: 'Less than'},
                {id:'>=', text: 'Greater than or equal to'},
                {id:'<=', text: 'less than or equal to'},
            ],
            compare_op2:[
                {id:'=', text: 'Equal'},
                {id: '!=', text: 'Not equal'},
                {id:'>', text: 'Greater than'},
                {id:'<', text: 'Less than'},
                {id:'>=', text: 'Greater than or equal to'},
                {id:'<=', text: 'less than or equal to'},
            ],
            reportType:'SINGLE',
            actionBtn:0,
            selectDays:false,
            selectDaysTwo:false,
            dateSelect:true,
            dateSelectTwo:false,
            dateSelectField:false,
            dateSelectFieldTwo:false,
            form: {
                id: undefined,
                compare_op:null,
                compare_op2:null,
                dateField: null,
                dateField2:null,
                dataField: null,
                dataField2:null,
                startDate:null,
                startDate2:null,
                endDate:null,
                endDate2:null,
                input:null,
                input2:null,
                report_type: this.data.reportType,

            }
        }
    },

    created () {
         this.reportType = this.data.reportType;
             this.typeField = this.data.typeDate;
            var j = 0

    //  start Create select option
            for(j=0; j<this.typeField.length; j++){
                // this.form.dateField = this.typeField[j].id
                this.dateField.push({
                    id: this.typeField[j].id,
                    text: this.typeField[j].field_name
                })
            }
        this.typeFieldData = this.data.typeData;
        var j = 0
            for(j=0; j<this.typeFieldData.length; j++){
              //  this.form.dataField = this.typeFieldData[0].id
                this.dataField.push({
                    id: this.typeFieldData[j].id,
                    text: this.typeFieldData[j].field_name
                })
            }

         if (this.data.reportType == 'COMPARE') {
             this.typeField2 = this.data.typeDate;
            var j = 0
            for(j=0; j<this.typeField2.length; j++){
              //  this.form.dateField2 = this.typeField2[0].id
                this.dateField2.push({
                    id: this.typeField2[j].id,
                    text: this.typeField2[j].field_name
                })
            }
        this.typeFieldData2 = this.data.typeData;
        var j = 0
            for(j=0; j<this.typeFieldData2.length; j++){
              //  this.form.dataField2 = this.typeFieldData2[0].id
                this.dataField2.push({
                    id: this.typeFieldData2[j].id,
                    text: this.typeFieldData2[j].field_name
                })
            }
         } //  end Create select option

        //when  request edit start
        if(this.data.edit == 'yes'){
            this.actionBtn = 1
            for (let a = 0; a < this.data.repData.length; a++) {
                if(this.data.repData[a]['filter_type'] == 1){
                 this.form.input = this.data.repData[a]['compare_value'];
                    this.form.compare_op = this.data.repData[a]['compare_operator'];
                    this.form.dataField = this.data.repData[a]['form__fields_id'];
                }
                if(this.data.repData[a]['filter_type'] == 2){

                    this.form.input2 = this.data.repData[a]['compare_value'];
                    this.form.compare_op2 = this.data.repData[a]['compare_operator'];
                    this.form.dataField2 = this.data.repData[a]['form__fields_id'];
                }
            }

             for (let b = 0; b < this.data.repDate.length; b++) {


                 if(this.data.repDate[b]['filter_type'] == 1){
                 this.form.dateField = this.data.repDate[b]['form__fields_id'];
                   // this.form.startDate = totalDays;
                     this.form.startDate = this.data.repDate[b]['start_date'];
                    this.form.endDate = this.data.repDate[b]['end_date'];
                }
                if(this.data.repDate[b]['filter_type'] == 2){
                     this.form.dateField2 = this.data.repDate[b]['form__fields_id'];
                    this.form.startDate2 = this.data.repDate[b]['start_date'];
                    this.form.endDate2 = this.data.repDate[b]['end_date'];
                }
            }

   //start select days wise date
   //          if (this.data.repDate !=null){
   //
   //
   //
   //              if(this.data.repDate[0].filter_type == 1){
   //                  this.dateSelectField = true
   //                  this.dateSelect = false
   //
   //              }
   //              if(this.data.repDate[1].filter_type == 2){
   //                   this.dateSelectTwo = true
   //                  this.dateSelectFieldTwo = true
   //
   //              }
   //          }else{
   //              this.dateSelect = true;
   //          }
   //end select days wise date



        }//End requent edit



    },
    methods: {
        // onChange:function (event, filter_type){
        //     let dayCount =  event.target.value
        //     let toDay=   moment().format('YYYY-MM-DD');
        //
        //     alert(toDay)
        //     if(dayCount == 7 || dayCount == 15){
        //         let totalDays =  moment().subtract(dayCount,'day').format('YYYY-MM-DD');
        //
        //         if(filter_type == 1){
        //             this.selectDays=true;
        //             this.form.startDate = totalDays;
        //             this.form.endDate = toDay;
        //         }
        //         if(filter_type == 2){
        //             this.selectDaysTwo=true;
        //             this.form.startDate2 = totalDays;
        //             this.form.endDate2 = toDay;
        //         }
        //     }else{
        //         if(filter_type == 1){
        //             this.selectDays=true;
        //             this.form.startDate = null;
        //             this.form.endDate = null;
        //         }
        //         if(filter_type == 2){
        //             this.selectDaysTwo=true;
        //             this.form.startDate2 = null;
        //             this.form.endDate2 = null;
        //         }
        //
        //     }
        //
        // },
        onFileChange: function (e) {
            this.photo = e.target.files[0]
        },
        MakeActive: function(field){
            this.active_field = field
        },
        AddOption: function(){
            this.active_field.options.push(this.field_options)
            this.field_options = {}
        },

        save: function (params) {
             var data = new FormData()
            this.$inertia.post('/reports/generate/'+this.data.slug+'/preview', params)
        },
        cancel: function () {
            this.$inertia.get('/reports/generate/'+ this.data.report.slug+'/dataRepresentation')
        },

    }
}
</script>

