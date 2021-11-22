<template>
    <app-layout>
        <Model :data="data" :editMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
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
import AppLayout from '@/Layouts/AppLayout'
import Model from './components/Model'
import Header from '@/Pages/Component/Header'
export default {
    components: {
        AppLayout,
        Model,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Update Organization Group',
            link: 'organization-group.index',
            label: 'Organization Group'
        }
    },
    mounted() {
      console.log('sazzad',this.data);
    }
}
</script>
