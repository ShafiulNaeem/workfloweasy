<template>
    <app-layout>
        <Form :data="data" :errors="errors" :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Form>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Models from './components/Mode'
import Form from './components/Form'
import Header from '@/Pages/Component/Header'

export default {
    components: {
        AppLayout,
        Models,
        Form,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Form Create',
            link: 'forms.index',
            label: 'Forms'
        }
    }
}
</script>
