import swal from 'sweetalert2'
window.Swal = swal

export function success_message(message){
    Swal.fire({
        icon: 'success',
        title: message,
        showConfirmButton: false,
        timer: 1500
    })
}

export function error_message(errors){
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
