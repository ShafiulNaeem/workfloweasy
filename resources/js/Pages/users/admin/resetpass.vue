<template>
    <app-layout>
        <Modelreset :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Modelreset>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header'
import Modelreset from './components/Modelreset.vue'
export default {
    components: {
        AppLayout,
        Header,
        Modelreset
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Reset Passord',
            link: 'admins.index',
            label: 'Client Manager'
        }
    },
    mounted () {

    }
}
</script>
