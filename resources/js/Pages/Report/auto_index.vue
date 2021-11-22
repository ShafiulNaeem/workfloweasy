<template>
    <app-layout>
        <Automations :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Automations>
    </app-layout>
</template>

<script>

import Automations from "./components/Automations";
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header1'

export default {
    name: "auto_index",
    components: {
        AppLayout,
        Automations,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Report Automation',
            link: 'reportAutomation.create',
            label: 'Report'
        }
    }
}
</script>

<style scoped>

</style>
