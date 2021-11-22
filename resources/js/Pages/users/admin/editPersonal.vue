<template>
    <app-layout>
        <modelpersonal :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </modelpersonal>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header'
import Modelpersonal from './components/Modelpersonal.vue'
export default {
    components: {
        AppLayout,
        Header,
        Modelpersonal
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Update Peronal',
            link: 'admins.index',
            label: 'Client Manager'
        }
    },
    mounted () {

    }
}
</script>
