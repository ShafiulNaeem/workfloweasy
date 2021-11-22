<template>
    <div>
        <div v-if="flash.message" :type="flash.message | success"></div>
        <div v-if="Object.keys(errors).length" :type="errors | error"></div>
    </div>
</template>

<script>
import JetResponsiveNavLink from '@/Jetstream/ResponsiveNavLink'
import swal from 'sweetalert2'
window.Swal = swal

export default {
    components: {
        JetResponsiveNavLink
    },
    props: ['errors', 'title', 'flash', 'link', 'label'],
    filters: {
        success (status) {
            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: toast => {
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            })

            Toast.fire({
                icon: 'success',
                title: status
            })
        },
        error (errors) {
            let list = []
            $.each(errors, function (key, value) {
                list.push(value)
            })

            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: list[0],
                showConfirmButton: false,
                timer: 1500
            })
        }
    }
}
</script>
