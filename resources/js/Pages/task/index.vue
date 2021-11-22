<template>
    <app-layout>
        <Models :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Models>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Models from './components/Models'
import Header from '@/Pages/Component/Header1'

export default {
    components: {
        AppLayout,
        Models,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'To-Dos',
            link: 'tasks.create',
            label: 'Task Board'
        }
    }
}
</script>
