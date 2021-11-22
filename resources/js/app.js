require('./bootstrap');
import 'vue-datetime/dist/vue-datetime.css'
import 'vue2-datepicker/index.css'

import Vue from 'vue';
import moment from 'moment'

// import {VueTabs} from 'vue-nav-tabs'
// import 'vue-nav-tabs/themes/vue-tabs.css'
// Vue.use(VueTabs);

import { InertiaApp } from '@inertiajs/inertia-vue';
import { InertiaForm } from 'laravel-jetstream';
import PortalVue from 'portal-vue';
import VueRouter from 'vue-router'
import VueSweetalert2 from 'vue-sweetalert2';
import VueSlimScroll from 'vue-slimscroll'
import VModal from 'vue-js-modal'
import { Datetime } from 'vue-datetime';

import DatePicker from 'vue2-datepicker'

Vue.component('datetime', Datetime);
Vue.component('DatePicker', DatePicker);

Vue.mixin({ methods: { route } });
Vue.use(InertiaApp);
Vue.use(InertiaForm);
Vue.use(PortalVue);
Vue.use(VueRouter)
Vue.use(VueSweetalert2);
Vue.use(VueSlimScroll);
Vue.use(VModal)

Vue.filter('formatDateTime', function(value) {
    if (value) {
        return moment(String(value)).format('YYYY-MM-DD hh:mm:ss')
    }
});

Vue.filter('formatDate', function(value) {
    if (value) {
        return moment(String(value)).format('YYYY-MM-DD')
    }
});

// Vue.filter('formatDate', function(value) {
//     if (value) {
//         return moment(String(value)).format('MMMM Do YYYY')
//     }
// });

Vue.filter('formatTime', function(value) {
    if (value) {
        return moment(String(value)).format('h:mm:ss a')
    }
});


const app = document.getElementById('app');

new Vue({
    render: (h) =>
        h(InertiaApp, {
            props: {
                initialPage: JSON.parse(app.dataset.page),
                resolveComponent: (name) => require(`./Pages/${name}`).default,
            },
        }),
}).$mount(app);
