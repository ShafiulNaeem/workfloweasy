<template>
    <app-layout>
        <Report :data="data" :errors="errors" :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Report>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Report from './components/Report'
import Header from '@/Pages/Component/Header'

export default {
    components: {
        AppLayout,
        Report,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Generate Report',
            link: 'report.index',
            label: 'Report'
        }
    }
}
</script>
