<template>
 <div>

<!--    <vue-html2pdf-->
<!--        :show-layout="false"-->
<!--        :float-layout="true"-->
<!--        :enable-download="true"-->
<!--        :preview-modal="false"-->
<!--        :paginate-elements-by-height="1550"-->
<!--        :filename="data.report.report_name"-->
<!--        :pdf-quality="2"-->
<!--        :manual-pagination="false"-->
<!--        pdf-format="a4"-->
<!--        pdf-orientation="landscape"-->
<!--        pdf-content-width="1000px"-->

<!--        @progress="onProgress($event)"-->
<!--        @hasStartedGeneration="hasStartedGeneration()"-->
<!--        @hasGenerated="hasGenerated($event)"-->
<!--        ref="html2Pdf"-->
<!--    >-->
<!--        <section slot="pdf-content" class="mt-2 ml-2">-->

<!--            <div class="col-md-11" style="margin: 0 auto;">-->

<!--                <div class="col-md-12" style="padding: 0px;">-->
<!--                    <br>-->
<!--                    <h6 class="span_pdf_date_total"> {{data.report.report_name}}</h6>-->
<!--                    <h7 class="span_pdf_date_total"> WorkflowEasy</h7>-->
<!--                    <p class="span_pdf_date_total">Created at: {{moment(data.report.created_at).format("DD-MM-YYYY hh:mm a")}}</p>-->
<!--                </div>-->

<!--                <div class="col-md-12" style="padding: 0px;">-->
<!--                    <div v-if="reportType == 'COMPARE'" class="col-md-12" style="padding: 5px 0px">-->
<!--                        <span class="span_pdf_date_total">  Records #1</span>-->
<!--                    </div>-->
<!--                    <div class="col-md-12" style="padding: 0px; background-color: #DCDFE0;">-->
<!--                        <div class="row">-->
<!--                            <div class="col-md-6" v-if="dateData1 == true" style="padding: 5px 20px">-->
<!--                        <span class="span_pdf_date_total">-->
<!--                             {{dateField[1].text}} :-->
<!--                             {{moment(form.startDate).format("DD-MM-YYYY")}} To {{moment(form.endDate).format("DD-MM-YYYY")}}-->
<!--                        </span>-->
<!--                            </div>-->
<!--                            <div :class="dateData1 == true?'text-right':'text-left'" class="col-md-6" style="padding: 5px 20px">-->
<!--                                <span class="span_pdf_date_total"> Total Records: {{data.total_records_form_one}}</span>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                    <div class="col-md-12" style="padding: 0px;">-->
<!--                        <div class="table-responsive table1 scroll">-->
<!--                            <ul style="float:left; list-style:none" :style="{ width: width1 + '%' }" class="list-group">-->
<!--                                <li class="font-weight-bold">#</li>-->
<!--                                <li v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>-->
<!--                                <li v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>-->
<!--                                <li v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>-->
<!--                                <li v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>-->
<!--                            </ul>-->
<!--                            <div class="d-flex">-->
<!--                                <ul style="list-style:none; " :style="{ width: width1 + '%' }" class="list-group " v-for="row in  this.data.form_one">-->
<!--                                    <li >{{row.field_label}}</li>-->
<!--                                    <li  v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>-->
<!--                                    <li  v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>-->
<!--                                    <li  v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>-->
<!--                                    <li  v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>-->

<!--                                </ul>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->

<!--                <div v-if="reportType == 'COMPARE'" class="col-md-12" style="padding: 0px;">-->
<!--                    <div class="col-md-12" style="padding: 5px 0px">-->
<!--                        <span class="span_pdf_date_total">  Records #2</span>-->
<!--                    </div>-->
<!--                    <div class="col-md-12" style="padding: 0px; background-color: #DCDFE0;">-->
<!--                        <div class="row">-->
<!--                            <div class="col-md-6" v-if="dateData2 == true" style="padding: 5px 20px">-->
<!--                        <span class="span_pdf_date_total">-->
<!--                             {{dateField2[1].text}} :-->
<!--                             {{moment(form.startDate2).format("DD-MM-YYYY")}} To {{moment(form.endDate2).format("DD-MM-YYYY")}}-->
<!--                        </span>-->
<!--                            </div>-->
<!--                            <div :class="dateData2 == true?'text-right':'text-left'" class="col-md-6" style="padding: 5px 20px">-->
<!--                                <span class="span_pdf_date_total"> Total Records: {{data.total_records_form_two}}</span>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                    <div class="col-md-12" style="padding: 0px;">-->
<!--                        <div class="table-responsive table1 scroll">-->
<!--                            <ul style="float:left; list-style:none" :style="{ width: width2 + '%' }" class="list-group">-->
<!--                                <li class="font-weight-bold">#</li>-->
<!--                                <li v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>-->
<!--                                <li v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>-->
<!--                                <li v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>-->
<!--                                <li v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>-->
<!--                            </ul>-->
<!--                            <div class="d-flex">-->
<!--                                <ul style="list-style:none; " :style="{ width: width2 + '%' }" class="list-group " v-for="row in  this.data.form_two">-->
<!--                                    <li >{{row.field_label}}</li>-->
<!--                                    <li  v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>-->
<!--                                    <li  v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>-->
<!--                                    <li  v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>-->
<!--                                    <li  v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>-->

<!--                                </ul>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->


<!--            </div>-->

<!--            <div class="col-md-11" style="margin: 0 auto;">-->
<!--                <div class="row" :style="reportType == 'COMPARE'?'margin-top: 20px':'margin-top: 370px'">-->
<!--                    <div class="col-md-6" style="padding-left: 20px;">-->
<!--                        <p>-->
<!--                            <span style="font-size: 12px;">{{data.report.report_name}} - WorkFlowEasy</span><br>-->
<!--                            <span  style="font-size: 12px;">Created at: {{moment(data.report.created_at).format("DD-MM-YYYY hh:mm a")}}</span>-->
<!--                        </p>-->
<!--                    </div>-->
<!--                    <div class="col-md-6">-->
<!--                        <p class="text-right">-->
<!--                            <span style="font-size: 12px;">Created on: {{ moment(new Date()).format("DD-MM-YYYY hh:mm a") }}</span><br>-->
<!--                            <span style="font-size: 12px;">Page 1/1</span>-->
<!--                        </p>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->

<!--        </section>-->
<!--    </vue-html2pdf>-->

     <vue-html2pdf
         :show-layout="false"
         :float-layout="true"
         :enable-download="true"
         :preview-modal="false"
         :paginate-elements-by-height="800"
         :filename="data.report.report_name"
         :pdf-quality="2"
         :manual-pagination="false"
         pdf-format="a4"
         pdf-orientation="landscape"
         pdf-content-width="1000px"

         @progress="onProgress($event)"
         @hasStartedGeneration="hasStartedGeneration()"
         @hasGenerated="hasGenerated($event)"
         ref="html2Pdf"
     >
         <section slot="pdf-content" class="mt-2 ml-2">

             <div class="col-md-11" style="margin: 0 auto;">

                 <div class="col-md-12" style="padding: 0px;  border-bottom: 1px solid gray;">
                     <br>
                     <h6 class="span_pdf_date_total"> {{data.report.report_name}}</h6>
                     <h7 class="span_pdf_date_total"> WorkflowEasy</h7>
                     <p class="span_pdf_date_total">Generated at: {{moment(data.report.created_at).format("DD-MM-YYYY hh:mm a")}}</p>
                 </div>

                 <div class="row">
                     <div style="padding-top: 5px;" :class="reportType == 'COMPARE' ? 'col-md-6' : 'col-md-11' ">

                         <div class="row" :style="dateData1 == true ? 'padding-left: 15px;margin-bottom: -34px;':''" :class="reportType == 'COMPARE' ? '' : 'col-md-8'" >
                             <div class="col-md-3" style="padding:0px;" v-if="dateData1 == true">
                                 <div class="form-group" >
                                     <Select2 :options="dateField" v-model="form.field_type"   placeholder="select option"/>
                                 </div>
                             </div>
                             <div class="col-md-3"  style="padding:0px;" v-if="dateData1 == true">
                                 <div class="form-group">
                                     <datetime  style="float: left;" v-model="form.startDate"
                                                disabled
                                                type="date"
                                                wrapper-class="my-wrapper-class"
                                                input-class="my-input-class datetime_style_pdf"
                                                placeholder="Start date"
                                     ></datetime>
                                 </div>
                             </div>
                             <div class="col-md-3"  style="padding:0px;" v-if="dateData1 == true">
                                 <div class="form-group" >
                                     <datetime style="float: left;"  v-model="form.endDate"
                                               disabled
                                               type="date"
                                               wrapper-class="my-wrapper-class"
                                               input-class="my-input-class datetime_style_pdf"
                                               placeholder="End date"
                                     ></datetime>
                                 </div>
                             </div>
                             <div :style="dateData1 == true ? 'padding: 0px;':''" class="mt-2" :class="dateData1 == false ?'col-md-12':'col-md-3'"><p>Total Records: <b>{{data.total_records_form_one}}</b></p></div>
                         </div>

                         <div>
                             <div class="table-responsive table1">
                                 <ul style="float:left; list-style:none;" :style="{ width: width1 + '%' }" class="list-group">
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" class="font-weight-bold">#</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" style=" " v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'"  v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" style="  display: inline-block;" v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" style="display: inline-block;" v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>
                                 </ul>
                                 <div class="d-flex">
                                     <ul style="list-style:none; " :style="{ width: width2 + '%' }" class="list-group " v-for="row in  this.data.form_one">
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'">{{row.field_label}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>

                                     </ul>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div style="padding-top: 5px;" v-if="reportType == 'COMPARE' " class="col-md-6  ">

                         <div class="row" :style="dateData2 == true ? 'padding-left: 15px;margin-bottom: -34px;':''" >
                             <div class="col-md-3" style="padding:0px" v-if="dateData2 == true">
                                 <div class="form-group" >
                                     <Select2 :options="dateField2" v-model="form.field_type2"  placeholder="select option"/>
                                 </div>
                             </div>
                             <div class="col-md-3"  style="padding:0px;" v-if="dateData2 == true">
                                 <div class="form-group">
                                     <datetime style="float: left;"  disabled v-model="form.startDate2"
                                               type="date"
                                               wrapper-class="my-wrapper-class"
                                               input-class="my-input-class datetime_style_pdf"
                                               placeholder="Start date"
                                     ></datetime>
                                 </div>
                             </div>
                             <div class="col-md-3"  style="padding:0px;" v-if="dateData2 == true">
                                 <div class="form-group">
                                     <datetime style="float: left;" disabled v-model="form.endDate2"
                                               type="date"
                                               wrapper-class="my-wrapper-class"
                                               input-class="my-input-class datetime_style_pdf"
                                               placeholder="End date"
                                     ></datetime>
                                 </div>
                             </div>
                             <div :style="dateData2 == true ? 'padding: 0px;':''" class="mt-2" :class="dateData2 == false ?'col-md-12':'col-md-3'"><p>Total Records: <b>{{data.total_records_form_two}}</b></p></div>
                         </div>

                         <div>
                             <div class="table-responsive table1 scroll">
                                 <ul style="float:left; list-style:none" :style="{ width: width2 + '%' }" class="list-group">
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" class="font-weight-bold">#</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>
                                     <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>
                                 </ul>
                                 <div class="d-flex">
                                     <ul style="list-style:none; " :style="{ width: width2 + '%' }" class="list-group " v-for="row in  this.data.form_two">
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" >{{row.field_label}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>
                                         <li :style="width1 < 25 ? 'font-size: 12px': 'font-size: 14px'" v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>

                                     </ul>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>

             </div>

             <div class="col-md-11" style="margin: 0 auto;">
                 <div class="row" style="margin-top: 330px;">
                     <div class="col-md-6" style="padding-left: 20px;">
                         <p>
                             <span style="font-size: 12px;">{{data.report.report_name}} - WorkFlowEasy</span><br>
                             <span  style="font-size: 12px;">Generated By: {{data.report.created_by_user?data.report.created_by_user.name:''}}</span>
                         </p>
                     </div>
                     <div class="col-md-6">
                         <p class="text-right">
                             <span style="font-size: 12px;">Created at: {{ moment(new Date()).format("DD-MM-YYYY hh:mm a") }}</span><br>
                             <span style="font-size: 12px;">Page 1/1</span>
                         </p>
                     </div>
                 </div>
             </div>

         </section>
     </vue-html2pdf>

     <div class="row">
        <div :class="reportType == 'COMPARE' ? 'col-md-6' : 'col-md-11' ">
              <div class="row" :style="dateData1 == true ? 'padding-left: 15px;margin-bottom: -34px;':''" :class="reportType == 'COMPARE' ? '' : 'col-md-8'" >
                <div class="col-md-3" style="padding:0px;" v-if="dateData1 == true">
                    <div class="form-group" >
                        <Select2 :options="dateField" v-model="form.field_type"   placeholder="select option"/>
                    </div>
                </div>
                <div class="col-md-3"  style="padding:0px;" v-if="dateData1 == true">
                    <div class="form-group">
                        <datetime  style="float: left;" v-model="form.startDate"
                                   disabled
                                  type="date"
                                  wrapper-class="my-wrapper-class"
                                  input-class="my-input-class datetime_style_date"
                                  placeholder="Start date"
                        ></datetime>
                    </div>
                </div>
                <div class="col-md-3"  style="padding:0px;" v-if="dateData1 == true">
                    <div class="form-group" >
                        <datetime style="float: left;"  v-model="form.endDate"
                                  disabled
                                  type="date"
                                  wrapper-class="my-wrapper-class"
                                  input-class="my-input-class datetime_style_date"
                                  placeholder="End date"
                        ></datetime>
                    </div>
                </div>
                <div :style="dateData1 == true ? 'padding: 0px;':''" class="col-md-3 mt-2"><p>Total Records: <b>{{data.total_records_form_one}}</b></p></div>
          </div>
              <div>
                <div class="table-responsive table1 scroll">
              <ul style="float:left; list-style:none" class="list-group">
                  <li class="font-weight-bold">#</li>
                  <li v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>
                  <li v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>
                  <li v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>
                  <li v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>
              </ul>
              <div class="d-flex">
                  <ul style="list-style:none; " class="list-group " v-for="row in  this.data.form_one">
                      <li >{{row.field_label}}</li>
                      <li  v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>
                      <li  v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>
                      <li  v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>
                      <li  v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>

                  </ul>
              </div>
          </div>
              </div>
        </div>
        <div v-if="reportType == 'COMPARE' " class="col-md-6">
           <div class="row" :style="dateData2 == true ? 'padding-left: 15px;margin-bottom: -34px;':''" >
                    <div class="col-md-3" style="padding:0px" v-if="dateData2 == true">
                        <div class="form-group" >
                            <Select2 :options="dateField2" v-model="form.field_type2"  placeholder="select option"/>
                        </div>
                    </div>
                    <div class="col-md-3"  style="padding:0px;" v-if="dateData2 == true">
                        <div class="form-group">
                            <datetime style="float: left;"  disabled v-model="form.startDate2"
                                      type="date"
                                      wrapper-class="my-wrapper-class"
                                      input-class="my-input-class datetime_style_date"
                                      placeholder="Start date"
                            ></datetime>
                        </div>
                    </div>
                    <div class="col-md-3"  style="padding:0px;" v-if="dateData2 == true">
                        <div class="form-group">
                            <datetime style="float: left;" disabled v-model="form.endDate2"
                                      type="date"
                                      wrapper-class="my-wrapper-class"
                                      input-class="my-input-class datetime_style_date"
                                      placeholder="End date"
                            ></datetime>
                        </div>
                    </div>
                    <div :style="dateData2 == true ? 'padding: 0px;':''" class="col-md-3 mt-2"><p>Total Records: <b>{{data.total_records_form_two}}</b></p></div>
              </div>
          <div>
<!--              :style="dateData2 == false ? 'margin-top: 57px':''"-->
               <div class="table-responsive table1 scroll">
                <ul style="float:left; list-style:none" class="list-group">
                    <li class="font-weight-bold">#</li>
                    <li v-if="data.representation.total == 1" class="font-weight-bold" >Total</li>
                    <li v-if="data.representation.average == 1"  class="font-weight-bold">Average</li>
                    <li v-if="data.representation.lowest == 1"  class="font-weight-bold">Lowest</li>
                    <li v-if="data.representation.highest == 1" class="font-weight-bold" >Highest</li>
                 </ul>
                 <div class=" d-flex">
                 <ul style="list-style:none; "class="list-group " v-for="row in  this.data.form_two">
                   <li >{{row.field_label}}</li>
                   <li  v-if="data.representation.total == 1" >{{isNaN(parseFloat(row.sum).toFixed(2)) ? 'Empty':parseFloat(row.sum).toFixed(2) }}</li>
                   <li  v-if="data.representation.average == 1"  >{{isNaN(parseFloat(row.avg).toFixed(2)) ? 'Empty':parseFloat(row.avg).toFixed(2)}}</li>
                   <li  v-if="data.representation.lowest == 1"  >{{isNaN(parseFloat(row.min).toFixed(2)) ? 'Empty':parseFloat(row.min).toFixed(2)}}</li>
                   <li  v-if="data.representation.highest == 1"  >{{isNaN(parseFloat(row.max).toFixed(2)) ? 'Empty':parseFloat(row.max).toFixed(2)}}</li>

                 </ul>
                 </div>
           </div>
          </div>
    </div>
     </div>

     <div v-if="data.viewToPreview == 'true'" :class="reportType == 'COMPARE' ? 'col-md-12' : 'col-md-11' " class="mb-5">
        <button
            style="margin-right: 0px;"
            type="button"
            class="form-submit-btn  ml-10  pull-right "
            wire:click.prevent="store()"
            @click="Edit()"
        >
           Edit
        </button>
        <button
            style="background-color: red"
            type="button"
            class="form-submit-btn ml-10 pull-right "
            wire:click.prevent="store()"
            @click="generatePdf"
        >
           Export
        </button>
<!--        <button-->
<!--            style="background-color: #F1C40F"-->
<!--            type="button"-->
<!--            class="form-submit-btn  ml-10  pull-right "-->
<!--            wire:click.prevent="store()"-->
<!--            @click="sendMailPdf()"-->
<!--        >-->
<!--           Email-->
<!--        </button>-->
     </div>
     <div v-else :class="reportType == 'COMPARE' ? 'col-md-12' : 'col-md-11' " class="mb-5">
        <button
            style="background-color: red; margin-right: 0px;"
            type="button"
            class="form-submit-btn  ml-10  pull-right "
            wire:click.prevent="store()"
            @click="cancel()"
        >
            Go Back
        </button>
     </div>

   </div>

</template>
<script>
import Alert from '@/Pages/Component/Alert';
import { Datetime } from 'vue-datetime';
import 'vue-datetime/dist/vue-datetime.css';
import moment from "moment";
import draggable from 'vuedraggable';
import Select2 from 'v-select2-component';
import { jsPDF } from "jspdf";
import VueHtml2pdf from 'vue-html2pdf';


export default {
   components: {
        Alert,
        draggable,
        datetime: Datetime,
        Select2,
        VueHtml2pdf,
        jsPDF,

    },


  props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],

    data(){
      return{
          moment:moment,
          dateField:[{id:null, text:''}],
          dateField2:[{id:null, text:''}],
          totalRecords2:[],
          dateData1:false,
          dateData2:false,
          width1:0,
          width2:0,
          form:{
               startDate:null,
               startDate2:null,
               endDate:null,
               endDate2:null,
               field_type: 1,
               field_type2: 1

          },
          getData: [],
          reportType:'SINGLE'
      }
    },
    created (){
        this.reportType = this.data.report_type

        // set width
        if (this.data.form_one != null){
            this.width1 = 100/(this.data.form_one.length+1)
        }

        if (this.data.form_two != null){
            this.width2 = 100/(this.data.form_two.length+1)
        }

        if(this.data.date_filter2_report_id_1 != null ){
            this.dateData1 = true

        }

        if(this.data.date_filter2_report_id != null ){
            this.dateData2 = true
        }

        // For date 1 Filter
        if (this.data.date_1 != null){
            if(this.data.date_1.form__fields_id == this.data.date_1.form_id){
                this.dateField.push({
                    id: 1,
                    text: 'Created at'
                })
            }else{
                this.dateField.push({
                    id: 1,
                    text: this.data.date_1?this.data.date_1.forms_fields.field_name:null
                })
            }
        }

         this.form.startDate = this.data.date_1?this.data.date_1.start_date:null
         this.form.endDate = this.data.date_1?this.data.date_1.end_date:null

        // For date 2 Filter
        if(this.data.report.type == 'COMPARE'){
            this.form.startDate2 = this.data.date_2?this.data.date_2.start_date:null
            this.form.endDate2 = this.data.date_2?this.data.date_2.end_date:null

            if (this.data.date_2 != null){
                if(this.data.date_2.form__fields_id == this.data.date_2.form_id){
                    this.dateField2.push({
                        id: 1,
                        text: 'Created at'
                    })
                }else{
                    this.dateField2.push({
                        id: 1,
                        text: this.data.date_2.forms_fields.field_name
                    })
                }
            }
       }

        // this.dateField.push({
        //   id: 1,
        //   text: this.data.date_1.forms_fields.field_name
        // })
        //  this.dateField2.push({
        //   id: 1,
        //   text: this.data.date_2.forms_fields.field_name
        // })



        },


    methods:{
      generatePdf:function(){
      //   const doc = new jsPDF();
      //   let refs = this.$refs.content;
      //   let htmlToConvert= renderToString(refs)
      // //   doc.fromHTML(this.$refs.content,{
      // //   'width' :150
      // // });
      // doc.fromHTML(htmlToConvert)
      //   // doc.text('this psf dw', 15,15)
      //   doc.save('save.pdf')
        this.$refs.html2Pdf.generatePdf()
      },
     sendMailPdf: function () {
         this.$inertia.get('/send-email-pdf/'+ this.data.report.slug)
     },
     Edit: function () {
         this.$inertia.get('/reports/generate/'+ this.data.report.slug)
     },
     cancel: function () {
        this.$inertia.get('/reports/generate/'+ this.data.report.slug+'/filter')
    },
    }

}
</script>
<style scoped>

/* table {
  width: 100%;
  border-collapse: none;
  border:1px solid #ddd;
  white-space:nowrap;
}

td, th {
  text-align: center;
  padding:5px;
} */

/* ul{
  overflow-x: auto;
  width:200px;
   white-space: nowrap;
} */

.scroll {
  overflow-x: scroll;
  overflow-y: hidden;

}

.list-group-item {
    padding: 0.3rem 0.60em !important;
    text-align: center;

}
.top{
  margin-top: 30px;
}
.table1 {
    background-color: white;
}
.table1 ul li:nth-child(1){
    font-weight: bold;
    white-space:nowrap;
}

.table1 ul li:nth-child(odd){
    background-color: white;
    padding: 10px;


}
.table1 ul li:nth-child(even){
    background-color: #F6F6F6;
    padding: 10px;
    /*width: ;*/
}
.span_pdf_date_total{
    font-style: unset;
    color: #30272C;
    font-weight: 600;
}

</style>
