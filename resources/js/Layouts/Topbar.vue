<template>
 <div class="header">
    <div class="header-left">
        <a :href="route('dashboard')" class="logo">
            <img v-bind:src="'/assets/images/Inner-Logo-Icon.png'"  width="48" height="auto" alt="">
            <span><img v-bind:src="'/assets/images/Logo-Name.png'"  width="134" height="auto"  alt=""></span>
        </a>
    </div>
    <a id="toggle_btn" href="javascript:void(0)"><i class="fa fa-bars"></i></a>
    <!-- <a id="mobile_btn" class="mobile_btn float-left" href="#sidebar"><i class="fa fa-bars"></i></a> -->
    <ul class="nav user-menu float-right">
        <li class="nav-item dropdown has-arrow">
            <a href="#" class="dropdown-toggle nav-link user-link" data-toggle="dropdown">
                <span class="user-img">
                    <img v-bind:src="'/assets/img/user.jpg'" class="rounded-circle"  width="24" alt="Admin">
                    <span class="status online"></span>
                </span>

            </a>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="profile.html">My Profile</a>
                <a class="dropdown-item" :href="route('changePassword')">Change Password</a>
                <a class="dropdown-item" href="#">
                    <form @submit.prevent="logout">
                        <jet-dropdown-link as="button">
                            Logout
                        </jet-dropdown-link>
                    </form>
                </a>
            </div>
        </li>
    </ul>
    <div class="dropdown mobile-user-menu float-right">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
        <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="profile.html">My Profile</a>
            <a class="dropdown-item" :href="route('changePassword')">Change Password</a>
            <a class="dropdown-item" href="settings.html">Settings</a>
            <a class="dropdown-item" href="#">
                <form @submit.prevent="logout">
                    <jet-dropdown-link as="button">
                        Logout
                    </jet-dropdown-link>
                </form>
            </a>
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
    components: {
        JetApplicationMark,
        JetDropdown,
        JetDropdownLink,
        JetNavLink,
        JetResponsiveNavLink
    },
    methods: {
        logout() {
            axios.post(route('logout').url()).then(response => {
                window.location = '/';
            })
        },
    }
}
</script>
