import axios from 'axios';

// const HTTP = axios s
export const HTTP = axios.create({
    // baseURL: `https://workfloweasy.ca`,
    baseURL: `https://app.workfloweasy.ca`,
     // baseURL: `http://127.0.0.1:8000`,
    headers: {
        Authorization: 'Bearer {token}'
    }
})
