<template>
     <div class="page-wrapper user-color">
         <slot name="header"></slot>
         <!--         Navbar top start-->
         <div class="container-fluid user-bg-title">
             <div class="user-serchbox d-flex">
                 <div class="user-title capi">
                     <h2>{{ title }}</h2>
                 </div>
                 <div class="searchbox ml-auto">
                     <nav class="navbar user-nav d-flex nav-mr-top">
                         <form class="form-inline">
                             <div class="form-group">
                                 <select class="select_style form-control select" v-model="query.search_type" >
                                     <option  v-for="row in filter_types" :key="row.key_value" :value="row.key_value">{{ row.key_name }}</option>
                                 </select>
                             </div>
                             <div class="form-group">
                                 <input class="form-control mr-sm-2" v-model="query.search_text"  type="search" placeholder="enter your text" aria-label="Search">
                             </div>

                             <button @click="getData()" class="btn btn-outline-success my-2 my-sm-0 mr-4 ml-3" type="button">Search</button>
                         </form>
                         <a :href="route(link)" :active="route().current(link)" class="btn btn-primary btn-sm cls rg-top-btn"><i class="fa fa-plus"></i> Role</a>
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
                             <li class="breadcrumb-item">Manage {{title}}</li>
                         </ul>
                     </nav>
                 </div>

                 <div class="col-md-12">
                     <div class="table-responsive">
                         <form action="">
                             <div class="col-sm-12 date_root">
                                 <label class="date_export bold" for="" >Export: </label>

                                 <button style="float: right;" @click="getDateData()" class="btn btn-data my-2 my-sm-0 mr-4 ml-3" type="button" >Go</button>

                                 <div class="date_sub" style="">
                                     <input name="to_date" v-model="dateQuery.to_date" class="select_style" type="date" id="example-date-input">
                                 </div>
                                 <label class="date_lavel" for="example-date-input" >To </label>

                                 <div class="date_sub" >
                                     <input nmae="from_date" v-model="dateQuery.from_date" class="select_style" type="date">
                                 </div>
                                 <label class="date_lavel"  for="" >From </label>
                             </div>
                         </form>
                         <table class="table table-border table-striped custom-table datatable mb-0">
                             <thead>
                             <tr class="bg-white">
                                 <th>#</th>
                                 <th>Name</th>
                                 <th>Permissions</th>
                                 <th class="text-right">Action</th>
                             </tr>
                             </thead>
                             <tbody>
                             <tr v-for="(row,index) in data.data" :key="row.id">
                                 <td>{{ index+1 }}</td>
                                 <td>{{ row.name }}</td>
                                 <td> <span v-for="per in row.permissions" :key="per" > {{ per }} , </span> </td>
                                 <td class="text-right" >
                                     <div class="dropdown dropdown-action ">
                                            <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="true"><i class="fa fa-ellipsis-v"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right " x-placement="bottom-end" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(-91px, 27px, 0px);">
                                                <a class="dropdown-item" :href="route('roles.edit', [row.id])"><i class="fa fa-edit"></i> Edit</a>
                                                <button  @click="deleteRow(row)" class="dropdown-item"  data-toggle="modal" data-target="#delete_patient"><i class="fa fa-trash-o m-r-5"></i> Delete</button>
                                            </div>
                                        </div>
                                 </td>

                             </tr>
                             </tbody>
                         </table>
                     </div>
                 </div>
             </div>
         </div>
         <!--  Content end-->

<!--        <slot name="header"></slot>-->
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
             },
             dateQuery:{
                 from_date: '',
                 to_date: '',
             }
         }
     },
     mounted() {
         if (!_.isEmpty(this.data.query)) {
             this.query = this.data.query
         }
         if (!_.isEmpty(this.data.query)) {
             this.dateQuery = this.data.query
         }
     },
    methods: {
        resetQuery: function () {
            this.query = null
        },
        resetData: function () {
            this.resetQuery()
            this.$inertia.get('/roles', this.query)
        },
        getData: function () {
            this.$inertia.get('/roles', this.query)
        },
        getDateData: function () {
            this.$inertia.get('/roles', this.dateQuery)
        },
        deleteRow: function (data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/roles/' + data.id, data)
        }
    }
}
</script>
