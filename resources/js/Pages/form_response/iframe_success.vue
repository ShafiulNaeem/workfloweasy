<template>
    <app-layout>
        <Modelsucs :data="data" :editMode="1" :errors="errors">
            <template #header>

            </template>
        </Modelsucs>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayoutIframe'
import Modelsucs from './components/Modelsucs'
import Header from '@/Pages/Component/Header2'
export default {
    name: "iframe_success",
    components: {
        AppLayout,
        Modelsucs,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: this.data.Form_title,
            link: 'forms.index',
            label: 'Form List',

        }
    }
}
</script>

<style scoped>

</style>
