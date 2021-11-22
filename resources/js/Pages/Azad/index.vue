<template>
    <Models :name="name"/>
</template>
<script>
import Models from './components/Models'
export default {
    components:{
        Models
    },
    props:['name'],
    data(){
        return{
            name:'azad'
        }
    }
    
}
</script>