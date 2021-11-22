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
import Header from '@/Pages/Component/Header'
import Model from './components/Model.vue'
export default {
    components: {
        AppLayout,
        Header,
        Model
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'View User',
            link: 'admins.index',
            label: 'Client Manager'
        }
    },
    mounted () {

    }
}
</script>
