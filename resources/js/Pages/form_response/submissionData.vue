<template>
    <app-layout>
        <ViewData :data="data" :submissionMode="1" :errors="errors" :link="link" :title="title" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </ViewData>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header1'
import ViewData from './components/ViewData'

export default {
    name: "submissionData",
    components: {
        AppLayout,
        ViewData,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Form Data',
            link: 'tasks.pending_task',
            label: 'Information'
        }
    }

}
</script>

<style scoped>

</style>
