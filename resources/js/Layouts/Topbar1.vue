<template>
 <div class="header">
    <div class="header-left">
        <a :href="route('dashboard')" :active="route().current('dashboard')" class="logo">
            <img v-bind:src="'/assets/images/Inner-Logo-Icon.png'"  width="48" height="auto" alt="">
            <span><img v-bind:src="'/assets/images/Logo-Name.png'"  width="134" height="auto"  alt=""></span>
        </a>
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
    }
}
</script>
