<template>
    <app-layout>
        <Password :data="data" :changePassMode="1"  :errors="errors"  :title="title" :link="link" :label="label">
            <template #header>
                <Header
                    :title="title"
                    :flash="flash"
                    :errors="errors"
                    :link="link"
                    :label="label"
                />
            </template>
        </Password>
    </app-layout>
</template>

<script>
import AppLayout from '@/Layouts/AppLayout'
import Password from "@/Pages/organization/components/Password";
import Header from '@/Pages/Component/Header'
export default {
    name: "changePass",
    components: {
        AppLayout,
        Password,
        Header
    },
    props: ['data', 'errors', 'flash'],
    data () {
        return {
            title: 'Reset Password',
            link: 'organization-users.index',
            label: 'Client Manager'
        }
    }

}
</script>

<style scoped>

</style>
