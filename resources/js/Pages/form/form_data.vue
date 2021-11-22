<template>
    <app-layout>
        <Form_data :data="data" :errors="errors" :title="title" :flash="flash" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Form_data>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Form_data from './components/Form_data'
import Header from '@/Pages/Component/Header1'

export default {
    components: {
        AppLayout,
        Form_data,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Form Data',
            link: 'forms.precreate',
            label: 'Information'
        }
    }
}
</script>
