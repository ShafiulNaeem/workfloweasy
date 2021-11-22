<template>
    <app-layout>
        <PendingTask :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </PendingTask>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import PendingTask from './components/PendingTask'
import Header from '@/Pages/Component/Header1'

export default {
    components: {
        AppLayout,
        PendingTask,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Manage Task',
            link: 'tasks.create',
            label: 'Data & Submission'
        }
    }
}
</script>
