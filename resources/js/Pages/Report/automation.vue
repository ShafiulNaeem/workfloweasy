<template>
    <app-layout>
        <Automation :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Automation>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Automation from './components/Automation'
import Header from '@/Pages/Component/Header1'

export default {
    name: "automation",
    components: {
        AppLayout,
        Automation,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Create Report Automation',
            link: 'reportAutomation.index',
            label: 'Report'
        }
    }
}
</script>

<style scoped>

</style>
