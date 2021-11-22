<template>
    <app-layout>
        <EditData :data="data" :errors="errors" :link="link" :title="title" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </EditData>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header1'
import EditData from './components/EditData'
export default {
    components: {
        AppLayout,
        EditData,
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
