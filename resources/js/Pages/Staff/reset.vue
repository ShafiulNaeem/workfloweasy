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
import Modelreset from './components/Modelreset'
import Header from '@/Pages/Component/Header'
export default {
    components: {
        AppLayout,
        Modelreset,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Reset Password',
            link: 'staffs.index',
            label: 'Settings'
        }
    }
}
</script>
