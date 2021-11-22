<template>
    <div class="row">
        <div class="col-sm-12 col-3">
            <h4 class="page-title" style="text-align:center; font-size:35px;font-weight:bold;">
                {{ title ? title : 'AFC Hospital' }}
            </h4>
            <div v-if="flash.message" :type="flash.message | success"></div>
            <div v-if="Object.keys(errors).length" :type="errors | error"></div>
        </div>
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

        }
    }
}
</script>
