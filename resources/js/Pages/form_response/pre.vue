<template>
    <app-layout>
        <Models :data="data" :errors="errors">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                />
            </template>
        </Models>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Models from './components/Mode'
import Header from '@/Pages/Component/Header'

export default {
    components: {
        AppLayout,
        Models,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Form Info',
        }
    }
}
</script>
