<template>
    <app-layout>
        <Modelpass :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Modelpass>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Header from '@/Pages/Component/Header'
import Modelpass from './components/Modelpass'
export default {
    components: {
        AppLayout,
        Header,
        Modelpass
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Change Password',
            link: 'admins.index',
            label: 'Client Manager'
        }
    },
    mounted () {

    }
}
</script>
