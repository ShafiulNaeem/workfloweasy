<template>
    <app-layout>
        <Model :data="data" :viewMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Model>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Model from './components/Model'
import Header from '@/Pages/Component/Header'
export default {
    name: "view",
    components: {
        AppLayout,
        Model,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'View Department',
            link: 'departments.index',
            label: 'Settings'
        }
    }
}
</script>

<style scoped>

</style>
