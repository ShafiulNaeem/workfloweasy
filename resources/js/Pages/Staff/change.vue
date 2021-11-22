<template>
    <app-layout>
        <Modelchangepass :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Modelchangepass>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Modelchangepass from './components/Modelchangepass'
import Header from '@/Pages/Component/Header'
export default {
    components: {
        AppLayout,
        Modelchangepass,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Change Password',
            link: 'staffs.index',
            label: 'Settings'
        }
    }
}
</script>
