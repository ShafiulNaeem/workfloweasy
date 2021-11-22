<template>
    <div class="patient-create">
        <slot name="header"></slot>

        <div class="row justify-content-center" style="text-align:center">
            <div class="col-lg-6 card-box">
              <h2>{{data.Form_title}}</h2>
              <h2><i class="far fa-check-circle" style="color:green; font-size: 30px"></i> Data  Successfuly Submitted</h2>
              <button @click="goBack()" type="button" class="btn btn-primary" style="margin-top: 30px">Submit Again</button>
              
            </div>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import VueRecaptcha from 'vue-recaptcha';


export default {
    components: {
        Alert,
        VueRecaptcha,
        datetime: Datetime
    },
    props: ['data', 'editMode', 'errors'],
    data () {
        return {
            form: {
                id: undefined,
                Form_title: this.data.Form_title,
                description: this.data.description,
                category_id: this.data.category_id,
                fields: [],
                pass:null,
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

    },
    methods: {
       goBack(){
           history.back();
       }
    }
}
</script>
