<template>
    <app-layout>
        <Modelsucs :data="data" :editMode="1" :errors="errors">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Modelsucs>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout1'
import Modelsucs from './components/Modelsucs'
import Header from '@/Pages/Component/Header2'
export default {
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
