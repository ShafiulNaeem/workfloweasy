<template>
    <app-layout>
        <Model :data="data" :editMode="1" :errors="errors">
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
import AppLayout from '@/Layouts/AppLayout1'
import Model from './components/Model'
import Header from '@/Pages/Component/Header2'
export default {
    components: {
        AppLayout,
        Model,
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
