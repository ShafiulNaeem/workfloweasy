<template>
    <app-layout>
        <ViewAutomation :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </ViewAutomation>
    </app-layout>
</template>

<script>
import ViewAutomation from "./components/ViewAutomation";
import AppLayout from '@/Layouts/AppLayout';
import Header from '@/Pages/Component/Header1';

export default {
    name: "auto_view",
    components: {
        AppLayout,
        ViewAutomation,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'View Report Automation',
            link: 'reportAutomation.index',
            label: 'Report'
        }
    }
}
</script>

<style scoped>

</style>
