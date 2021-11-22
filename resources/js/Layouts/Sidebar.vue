<template>
    <div class="sidebar" id="sidebar">
        <div class="sidebar-inner "  v-slimscroll="options">
            <div id="sidebar-menu" class="sidebar-menu">
                <ul>
                    <li v-if="$page.auth.user.user_type == 'admin' " class="menu-title">Supper Admin</li>
                    <li v-else class="menu-title">{{$page.auth.user.organization.name}}</li>

                    <!-- Client Manager start-->
                    <li class="submenu">
                      <a href="#" v-if="$page.auth.user.menu_access.includes('user_management')">
                          <i class="fa fa-users"></i> <span> Client Manager </span> <span class="menu-arrow"></span>
                      </a>
                      <ul class="child-menu menu-title" :style="getMenu('user')" v-if="$page.auth.user.menu_access.includes('user_management')">

                        <li :class="getRoute('admins.index')" v-if="$page.auth.user.menu_access.includes('user_management')">
                          <jet-responsive-nav-link :href="route('admins.index')" :active="route().current('admins.index')">
                            <span> Manage Users </span>
                          </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('organization-users.index')"  v-if="$page.auth.user.menu_access.includes('organization_management')">
                            <jet-responsive-nav-link :href="route('organization-users.index')" :active="route().current('organization-users.index')">
                                <span> Organizations </span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('roles.index')" v-if="$page.auth.user.menu_access.includes('billing_management')">
                          <jet-responsive-nav-link :href="route('roles.index')" :active="route().current('roles.index')">
                            <span> Billing Management </span>
                          </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('roles.index')" v-if="$page.auth.user.menu_access.includes('support_management')">
                          <jet-responsive-nav-link :href="route('roles.index')" :active="route().current('roles.index')">
                            <span> Support </span>
                          </jet-responsive-nav-link>
                        </li>

                      </ul>
                    </li>
                      <!-- Client Manager end-->


                    <!-- Dashboard start-->
                        <li class="submenu" :class="getRoute('dashboard')" v-if="$page.auth.user.menu_access.includes('dashboard')">
                            <a href="#" @click="goBackDashboard()" v-if="$page.auth.user.menu_access.includes('dashboard')">
                                <i class="fas fa-chart-line"></i><span> Dashboard </span>
                            </a>
                        </li>

                    <li class="submenu">

                    <!-- Task Board start-->
                    <a href="#" v-if="$page.auth.user.menu_access.includes('task_management')">
                        <i class="fas fa-clipboard-list"></i>
                        <span> Task Board</span> <span class="menu-arrow"></span>
                    </a>
                    <ul class="child-menu menu-title" :style="getMenu('task')">
                        <li :class="getRoute('tasks.index')">
                            <jet-responsive-nav-link :href="route('tasks.index')" :active="route().current('tasks.index')">
                                <span>To-Dos</span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Calendar</span>
                            </jet-responsive-nav-link>
                        </li>

                </ul>
                    <!-- Task Board end-->

                    <!-- Communication start-->
                    <a href="#"><i class="fas fa-chalkboard" style="font-size: 15px !important;">
                    </i> <span> Communication</span> <span class="menu-arrow"></span>
                    </a>
                    <ul class="child-menu menu-title" :style="getMenu('communication')">
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Inbox</span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Sent</span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Draft</span>
                            </jet-responsive-nav-link>
                        </li>
                    </ul>
                    <!-- Communication end-->

                    <!-- Data & Submission start-->
                    <a href="#" v-if="$page.auth.user.menu_access.includes('data_management')"><i class="fas fa-table">
                        </i> <span> Information</span> <span class="menu-arrow"></span>
                    </a>
                    <ul class="child-menu menu-title" :style="getMenu('submission')" v-if="$page.auth.user.menu_access.includes('data_management')">
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Form Data</span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('forms.form_data')">
                            <jet-responsive-nav-link :href="route('forms.form_data')" :active="route().current('forms.form_data')">
                                <span>Run Report</span>
                            </jet-responsive-nav-link>
                        </li>
                    </ul>
                    <!-- Data & Submission end-->


                    <!-- Report start-->
                    <a href="#" v-if="$page.auth.user.menu_access.includes('report_management')">
                        <i class="fas fa-file-alt"></i> <span> Report</span> <span class="menu-arrow"></span>
                    </a>

                    <ul class="child-menu menu-title" :style="getMenu('report')" v-if="$page.auth.user.menu_access.includes('report_management')">

                        <li :class="getRoute('report.index')" v-if="$page.auth.user.menu_access.includes('report_management')">
                            <jet-responsive-nav-link :href="route('report.index')" :active="route().current('report.index')">
                                <span>Manage Report</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('reportAutomation.index')" v-if="$page.auth.user.menu_access.includes('report_management')">
                            <jet-responsive-nav-link :href="route('reportAutomation.index')" :active="route().current('reportAutomation.index')">
                                <span> Report Automation</span>
                            </jet-responsive-nav-link>
                        </li>

                    </ul>
                    <!-- Report end-->

                    <!-- Forms start-->
                    <a href="#" v-if="$page.auth.user.menu_access.includes('form_management')">
                        <i class="fas fa-align-justify"></i> <span> Forms</span> <span class="menu-arrow"></span>
                    </a>
                    <ul class="child-menu menu-title" :style="getMenu('form')" v-if="$page.auth.user.menu_access.includes('form_management')">

                        <li :class="getRoute('forms.index')"  v-if="$page.auth.user.menu_access.includes('form_management')">
                            <jet-responsive-nav-link :href="route('forms.index')" :active="route().current('forms.index')">
                                <span>Manage  Forms</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('formAutomation.index')" v-if="$page.auth.user.menu_access.includes('form_automation')">
                            <jet-responsive-nav-link :href="route('formAutomation.index')" :active="route().current('formAutomation.index')">
                                <span>Form Automation</span>
                            </jet-responsive-nav-link>
                        </li>

                    </ul>
                    <!-- Forms end-->

                    <!-- Settings start-->
                    <a href="#"  v-if="$page.auth.user.menu_access.includes('settings')">
                        <i class="fas fa-sliders-h"></i> <span> Settings</span> <span class="menu-arrow"></span>
                    </a>

                    <ul class="child-menu menu-title" :style="getMenu('setting')" v-if="$page.auth.user.menu_access.includes('settings')">

                        <li :class="getRoute('dashboard')" v-if="$page.auth.user.menu_access.includes('settings_billing')">
                            <jet-responsive-nav-link :href="route('dashboard')" :active="route().current('dashboard')">
                                <span> Billing </span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('organization.details')" v-if="$page.auth.user.user_type != 'admin'">
                            <jet-responsive-nav-link :href="route('organization.details')" :active="route().current('organization.details')">
                                <span>Organization Details </span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('staffs.index')" v-if="$page.auth.user.menu_access.includes('staff_management')">
                            <jet-responsive-nav-link :href="route('staffs.index')" :active="route().current('staffs.index')">
                                <span>Users </span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('roles.index')">
                            <jet-responsive-nav-link :href="route('roles.index')" :active="route().current('roles.index')">
                                <span>User Roles </span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('roles.index')">
                            <jet-responsive-nav-link :href="route('roles.index')" :active="route().current('roles.index')">
                                <span>User  Permission  </span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('departments.index')" v-if="$page.auth.user.menu_access.includes('settings_department')">
                            <jet-responsive-nav-link :href="route('departments.index')" :active="route().current('departments.index')">
                                <span>Departments</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('categories.index')" v-if="$page.auth.user.menu_access.includes('form_categories')">
                            <jet-responsive-nav-link :href="route('categories.index')" :active="route().current('categories.index')">
                                <span>Categories</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('type.index')" v-if="$page.auth.user.menu_access.includes('settings_department')">
                            <jet-responsive-nav-link :href="route('type.index')" :active="route().current('type.index')">
                                <span>Types</span>
                            </jet-responsive-nav-link>
                        </li>
                        <li :class="getRoute('dashboard')">
                            <jet-responsive-nav-link :href="route('dashboard')" :active="route().current('dashboard')">
                                <span>Calender Settings</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('tasks.index')">
                            <jet-responsive-nav-link :href="route('tasks.index')" :active="route().current('tasks.index')">
                                <span>Tasks Settings</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('dashboard')" v-if="$page.auth.user.menu_access.includes('settings_activity')">
                            <jet-responsive-nav-link :href="route('dashboard')" :active="route().current('dashboard')">
                                <span>Activity logs</span>
                            </jet-responsive-nav-link>
                        </li>

                        <li :class="getRoute('mail.index')" v-if="$page.auth.user.menu_access.includes('settings_department')">
                            <jet-responsive-nav-link :href="route('mail.index')" :active="route().current('mail.index')">
                                <span>Mail Settings</span>
                            </jet-responsive-nav-link>
                        </li>

                    </ul>
                    <!-- Settings end-->


<!--                      <a href="#"  v-if="$page.auth.user.menu_access.includes('task_management')"><i class="fas fa-tasks"></i> <span> Task Board</span> <span class="menu-arrow"></span></a>-->
<!--                      <ul class="child-menu" :style="getMenu('task')" v-if="$page.auth.user.menu_access.includes('task_management')">-->

<!--                        <li :class="getRoute('tasks.pending_task')">-->
<!--                          <jet-responsive-nav-link :href="route('tasks.pending_task')" :active="route().current('tasks.pending_task')">-->
<!--                            <span>Manage Task</span>-->
<!--                          </jet-responsive-nav-link>-->
<!--                        </li>-->
<!--                      </ul>-->

                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
import JetApplicationMark from '@/Jetstream/ApplicationMark'
import JetDropdown from '@/Jetstream/Dropdown'
import JetDropdownLink from '@/Jetstream/DropdownLink'
import JetNavLink from '@/Jetstream/NavLink'
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'

export default {
    props: ['croute','data'],
    data () {
        return {
            options:{
                height:'100%',
                size:2
            },
        }
    },
    components: {
        JetApplicationMark,
        JetDropdown,
        JetDropdownLink,
        JetNavLink,
        JetResponsiveNavLink,
    },
    methods: {
        getRoute(path) {
            if(this.croute === path) {
                return 'active'
            }
        },
        goBackDashboard(){
            this.$inertia.get('/dashboard');
        },
        getMenu(menu) {
            const user = [
                'admins.index', 'admins.create', 'admins.edit','admins.show','admin/reset','admin/password',
                'permissions.index','permissions.create',
                'organization-users.index', 'organization-users.create', 'organization-users.edit','organization-users.show','organization.changePassword'
            ]
            const organization = ['organization-users.index', 'organization-users.create']
            const taskBoard = [ 'tasks.index', 'tasks.create', 'tasks.edit','tasks.show']
            const setting = [
                'roles.index', 'roles.create', 'roles.edit',
                'staffs.index', 'staffs.create','member.edit','staffs.show','member.password','member.password.reset',
                'departments.index', 'departments.create',  'departments.edit','departments.show',
                'categories.index', 'categories.create',  'categories.edit','categories.show',
                'mail.index','mail.create',  'mail.edit','mail.show',
                'type.index', 'type.create', 'type.edit','type.show',
                'organization.details',
            ]
            const tasks = [
                 'tasks.index', 'tasks.create', 'tasks.edit','tasks.show',
            ]
            const report = [
                'report.index', 'reports.generate', 'reports.edit','reports.dataRepresentation','reports.filter','reports.preview',
                'reportAutomation.index','reportAutomation.create','reportAutomation.show'
            ]

            const form = [
                'forms.index', 'forms.create', 'forms.edit', 'forms.precreate','add_fields','form_settings',
                'forms.index', 'forms.generate','forms.create', 'forms.edit', 'forms.precreate','add_fields','form_settings','submissionData','editData',
                'form-department.index',  'form-department.create',  'form-department.edit',
                'formAutomation.index', 'formAutomation.create', 'formAutomation.edit','formAutomation.show'
            ]
            const submission = [
                'form.response.show', 'forms.form_data','submissionData','editData'
            ]
            if(menu === 'user' && user.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'organization' && organization.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'taskBoard' && taskBoard.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'setting' && setting.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'form' && form.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'task' && tasks.includes(this.croute)) {
                return 'display: block;'
            }
            if(menu === 'report' && report.includes(this.croute)) {
                return 'display: block;'
            }

            if(menu === 'submission' && submission.includes(this.croute)) {
                return 'display: block;'
            }
            return 'display: none;'
        }
    }
}
</script>

<style >
.child-menu {
    padding-left: 10%!important;
}
</style>
