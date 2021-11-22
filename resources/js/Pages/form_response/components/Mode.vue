<template>
    <div class="patient-create">
        <slot name="header"></slot>

        <div class="row">
            <div class="col-lg-12">
                    <form>
                      <div class="row justify-content-center">
                        <div class="col-md-8 card-box">
                          <div class="form-group">
                            <label for="name">Form Title</label>
                            <input type="text" class="form-control" id="name" v-model="form.Form_title">
                          </div>
                          <div class="form-group">
                            <label for="des">Form Description</label>
                            <textarea id="des" cols="30" rows="10" class="form-control" v-model="form.description"></textarea>
                          </div>
                          <div class="form-group">
                            <label>Category<span class="text-red">*</span></label>
                            <select class="form-control select" v-model="form.category_id">
                              <option v-for="cat in data.categories" :value="cat.id" :key="cat.id">{{cat.name}}</option>
                            </select>
                          </div>
                          <div class="text-danger" v-if="errors.organization_id">{{ errors.organization_id[0] }}</div>
                        </div>
                      </div>
                        <div class="m-t-20 text-center">
                            <button
                                type="button"
                                class="btn btn-primary submit-btn"
                                wire:click.prevent="store()"
                                v-show="!editMode"
                                @click="save(form)"
                            >
                                Create Form
                            </button>
                        </div>
                    </form>
            </div>
        </div>
    </div>
</template>

<script>
import Alert from '@/Pages/Component/Alert'
import { Datetime } from 'vue-datetime';
import moment from "moment";

export default {
    components: {
        Alert,
        datetime: Datetime
    },
    props: ['data', 'editMode', 'errors'],
    data () {
        return {
            form: {
                id: undefined,
                Form_title: "",
                description: ""

            }
        }
    },

    created () {
        if (this.editMode) {
            this.form = this.data
        }
    },
    methods: {
        reset: function () {
            this.form = {}
        },
        save: function (params) {
            var data = new FormData()
            this.$inertia.post('/forms/create', params)
        },
    }
}
</script>
