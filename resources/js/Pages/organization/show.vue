<template>
    <app-layout>
        <Details :data="data" :showMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Details>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Details from './components/Details'
import Header from '@/Pages/Component/Header'

export default {
    name: "show",
    components: {
        AppLayout,
        Details,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Organization Details',
            link: 'organization.details',
            label: 'Settings'
        }
    }
}
</script>

<style scoped>

</style>
