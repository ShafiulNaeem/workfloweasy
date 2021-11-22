<template>
    <app-layout>
        <Iframe :data="data" :editMode="1" :errors="errors">
            <template #header>

            </template>
        </Iframe>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayoutIframe';
import Iframe from './components/Iframe';
import Header from '@/Pages/Component/Header2';

export default {
    name: "iframe",
    components: {
        AppLayout,
        Iframe,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            // title: this.data.Form_title,
            link: 'forms.index',
            label: 'Form List',

        }
    }
}
</script>

<style scoped>

</style>
