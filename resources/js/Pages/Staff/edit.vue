<template>
    <app-layout>
        <Modeledit :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Modeledit>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Modeledit from './components/Modeledit'
import Header from '@/Pages/Component/Header'
export default {
    components: {
        AppLayout,
        Modeledit,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Update Member',
            link: 'staffs.index',
            label: 'Settings'
        }
    }
}
</script>
