<template>
    <div class="main-wrapper">
        <!-- Topbar -->
        <topbar1 />
        <!-- Sidebar -->

        <!-- Page Heading -->
        <!-- <header class="bg-white shadow">
            <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                <slot name="header"></slot>
            </div>
        </header> -->

        <!-- Page Content -->
        <main>
            <div >
                <div class="content">
                    <slot></slot>

                </div>
            </div>
        </main>

        <!-- Modal Portal -->
        <portal-target name="modal" multiple> </portal-target>
    </div>
</template>

<script>
import JetApplicationMark from '@/Jetstream/ApplicationMark'
import JetDropdown from '@/Jetstream/Dropdown'
import JetDropdownLink from '@/Jetstream/DropdownLink'
import JetNavLink from '@/Jetstream/NavLink'
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'
import Topbar1 from '@/Layouts/Topbar1'
import Vue from "vue";

export default {
    components: {
        JetApplicationMark,
        JetDropdown,
        JetDropdownLink,
        JetNavLink,
        JetResponsiveNavLink,
        Topbar1,
    },
    mounted() {
        const plugin = document.createElement("script");
        plugin.setAttribute(
            "src",
            "/assets/js/app.js"
        );
        plugin.async = true;
        document.head.appendChild(plugin);
    }
}
</script>

<style>
.new-btn {
    color: white;
}
</style>
