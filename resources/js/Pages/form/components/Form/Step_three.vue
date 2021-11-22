<template>
    <form>
        <div>
            <div class="row" style="margin-left: 2px;">

                <div class="col-md-5 card-box">
                    <h6>Share</h6>
                    <hr>
                    <div class="form-group">
                        <div class="form-check form-check-inline">
                            <input
                                v-model="form.is_public"
                                class="form-check-input"
                                type="radio"
                                name="is_public"
                                value="1"
                            />
                            <label
                                class="form-check-label"
                                for="product_active"
                            >
                                Public
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input
                                v-model="form.is_public"
                                class="form-check-input"
                                type="radio"
                                name="is_public"
                                value="0"
                            />
                            <label
                                class="form-check-label"
                                for="product_inactive"
                            >
                                Private
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <input type="checkbox" value="1" v-model="form.is_password_protected" @click="checkpass(form.is_password_protected)"> Password Protected
                        <input type="text" class="form-control" id="name" v-model="form.password" v-if="form.is_password_protected == true">
                        <div class="text-danger" v-if="error_check_password == 1 && form.is_password_protected == true">Field is required!</div>
                     </div>

                    <div class="form-group">
                        <label for="des">Form Permalink (URL)</label>
                        <textarea id="des" cols="10" rows="4" class="form-control" readonly>{{route('forms.response', [data.form.slug])}}</textarea>
                    </div>

                    <div class="form-group">
                        <label for="des">iFrame</label>
                        <textarea id="des" cols="10" rows="5" class="form-control" readonly>{{ '<iframe src="' + route('forms.iframe', [data.form.slug]) +'" frameborder="0"  style="overflow: hidden; height: 100%; width: 100%; position: absolute;"></iframe>' }}
                        </textarea>
                    </div>
                </div>
                <div class="col-md-5 card-box offset-md-1">
                    <h6>Notification</h6>
                    <hr>
                    <div class="form-group">
                        <input type="checkbox" value="1"> Disable From Notification <br/>
                        <input type="checkbox" value="1"> Receive Data Submission Notification
                    </div>
                    <div class="form-group">
                        <div class="form-group">
                            <input :checked="check" :value="check" @click="checkAutomation" type="checkbox"/> Automation
<!--                            <label class="all_level_margin">Automation</label>-->
                            <Select2 v-if="check == true" v-model="form.form_automation_id" :options="automations" />
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-md-11">
                <div class="m-t-20 text-center">

<!--                    <button-->
<!--                        type="button"-->
<!--                        class="save_form  pull-right  ml-10"-->
<!--                        wire:click.prevent="store()"-->
<!--                        @click="update(form, 'next')"-->
<!--                    >-->
<!--                        Next-->
<!--                    </button>-->
<!--                    <button-->
<!--                        type="button"-->
<!--                        class="save_form ml-10  pull-right "-->
<!--                        wire:click.prevent="store()"-->
<!--                        @click="update(form, 'preview')"-->
<!--                    >-->
<!--                        Preview-->
<!--                    </button>-->

                    <button
                        style="background-color: orange"
                        type="button"
                        class="form-submit-btn ml-10  pull-right "
                        wire:click.prevent="store()"
                        @click="update(form, 'preview')"
                        >
                        Preview
                    </button>
<!--                     <button-->
<!--                        type="button"-->
<!--                        class="form-submit-btn  pull-right  ml-10"-->
<!--                        wire:click.prevent="store()"-->
<!--                        @click="update(form, 'next')"-->
<!--                        >-->
<!--                        Next-->
<!--                    </button>-->

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
import {HTTP} from '@/utils/http-common'
import Select2 from 'v-select2-component';

export default {
    components: {
        Alert,
        datetime: Datetime,
        Select2
    },
    props: ['data', 'errors', 'editMode', 'link', 'title', 'label'],
    data () {
        return {
            categories:[],
            departments:[],
            check:false,
            error_check_password:0,
            automations:[{id: null, text: ''}],
            form: {
                is_password_protected: 0,
                is_public: 1,
                form_automation_id:null,
            }
        }
    },

    created () {
        if(this.data.setting){
            this.form = this.data.setting

            if (this.data.setting.form_automation_id != null){
                this.check = true
            }

        }else{
            this.form = {
                is_password_protected: 0,
                is_public: 1
            }
        }

        // automations
        let i = 0
        for(i=0; i<this.data.automations.length; i++){
            this.automations.push({
                id: this.data.automations[i].id,
                text: this.data.automations[i].name

            })
        }


    },
    methods: {
        checkpass(is_password_protected){
            if(is_password_protected == false) {
                this.error_check_password = 0
            }
        },
        checkAutomation(){
            if(this.check === false) {
                this.check = true
            }else {
                this.check = false
            }
        },
        update: function (params, type) {
            params['type'] = type;
            let error_check_password = 0;
            if (params['is_password_protected'] == true ){
                if ( params['password'] == null || params['password'] == ''){
                    error_check_password = 1
                }else{
                    error_check_password = 0
                }
            }
            if (params['is_password_protected'] == false){
                params['password']= null
            }
            if (this.check == false){
                params['form_automation_id']= null
            }
            this.error_check_password = error_check_password

            if (error_check_password == 0){
                this.$inertia.post('/forms/' + this.data.form.id + '/update-settings', params)

                if (params['type'] == 'preview'){
                    window.open('/form/response/' + this.data.form_slug, '_blank')
                }
            }

        },
    }
}
</script>
