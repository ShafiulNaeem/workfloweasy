<template>
    <div class="page-wrapper user-color">
        <slot name="header"></slot>
        <!--         Navbar top start-->
        <div class="container-fluid user-bg-title">
            <div class="user-serchbox d-flex">
                <div class="user-title capi">
                    <h2>new{{ title }}</h2>
                </div>
                <div class="searchbox ml-auto">
                    <nav class="navbar user-nav d-flex nav-mr-top">
                        <form class="form-inline">
                            <input class="form-control mr-sm-2" type="search" placeholder="name" aria-label="Search">
                            <button class="btn btn-outline-success my-2 my-sm-0 mr-4 ml-3" type="button">Search</button>
                        </form>
                        <a :href="route(link)" class="btn color_button"><i class="fa fa-plus"></i>New {{label}}</a>
                    </nav>

                </div>
            </div>
        </div>
        <!--         Navbar top end-->

        <!--         Content start-->
        <div class="container-fluid form-user-wrapper">
            <div class="row">
                <div class="breadcrumb-wrapper col-12 ">
                    <nav aria-label="Page breadcrumb">
                        <ul class="breadcrumb ml">
                            <li class="breadcrumb-item" aria-current="page">Main</li>
                            <li class="breadcrumb-item">{{label}}</li>
                            <li class="breadcrumb-item">{{title}}</li>
                        </ul>
                    </nav>
                </div>
                <table class="table table table-striped table-fn-size">
                    <thead>
                    <tr class="bg-white">
                        <th>#</th>
                        <th>Name</th>
                        <th v-if="$page.auth.user.user_type == 'admin'">Organization</th>
                        <th class="text-right">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="(row,index) in data.data" :key="row.id">
                        <td>{{ index+1}}</td>
                        <td>{{ row.name}}</td>
                        <td v-if="$page.auth.user.user_type == 'admin'">{{ row.organization.name }}</td>
                        <td class="text-right">
                            <a :href="route('organization-group.edit', [row.id])" class="btn color_button">Edit</a>
                            <a href="#" class="btn danger_button" @click="deleteRow(row)">Delete</a>
                        </td>

                    </tr>
                    </tbody>
                </table>

            </div>
        </div>
        <!--         Content end-->

<!--        <slot name="header"></slot>-->
<!--         <div class="card-box">-->
<!--             <form id="filter-form">-->
<!--               <div class="row">-->
<!--                     <div class="col-sm-4 col-3">-->
<!--                         <h4 class="page-title">-->
<!--                             {{ title ? title : 'Collamatic Bussiness Intelligent' }}-->
<!--                         </h4>-->
<!--                     </div>-->
<!--                     <div class="col-sm-8 col-3">-->
<!--                         <div class="row">-->
<!--                           <div class="col-md-3">-->
<!--                               <div class="form-group">-->
<!--                                   <select class="form-control select" v-model="query.search_type" >-->
<!--                                       <option  v-for="row in filter_types" :key="row.key_value" :value="row.key_value">{{ row.key_name }}</option>-->
<!--                                   </select>-->
<!--                               </div>-->
<!--                           </div>-->

<!--                           <div class="col-md-3">-->
<!--                               <div class="form-group">-->
<!--                                   <input type="text"   v-model="query.search_text"  class="form-control" placeholder="Type search text...">-->
<!--                               </div>-->
<!--                           </div>-->

<!--                           <div class="col-md-3">-->
<!--                               <button type="button" @click="getData()" class="btn btn-success btn-small pull-right"> Search </button>-->
<!--                               <button type="button" @click="resetData()" class="btn btn-warning btn-small"> Reset </button>-->
<!--                           </div>-->
<!--                             <div class="col-md-3">-->
<!--                                 <jet-responsive-nav-link-->
<!--                                     :href="route(link)"-->
<!--                                     :active="route().current(link)"-->
<!--                                     class="btn btn-primary btn-rounded float-right"-->
<!--                                     style="padding: 9px 10px !important;display: ruby-base !important;"-->
<!--                                 >-->
<!--                                     <i class="fa fa-plus new-btn" aria-hidden="true"></i>-->
<!--                                     <span class="new-btn"> &nbsp; {{ label }} </span>-->
<!--                                 </jet-responsive-nav-link>-->
<!--                             </div>-->
<!--                       </div>-->
<!--                         </div>-->
<!--                     </div>-->
<!--             </form>-->
<!--         </div>-->

    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'

 export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['data','title','flash','errors','link','label'],
     data() {
         return {
             filter_types: [
                 {'key_value': '', 'key_name': 'All'},
                 {'key_value': 'name', 'key_name': 'Name'},
             ],
             query: {
                 search_type: '',
                 search_text: ''
             }
         }
     },
     mounted() {
         if (!_.isEmpty(this.data.query)) {
             this.query = this.data.query
         }
     },
    methods: {
        resetQuery: function () {
            this.query = null
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/organization-group', this.query)
        },
        getData: function () {
            this.$inertia.get('/organization-group', this.query)
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/organization-group/' + data.id, data)
        }
    }
}
</script>
