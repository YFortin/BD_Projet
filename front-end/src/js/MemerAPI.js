import axios from 'axios';

export default class MemerAPI {
    static get BASE_URL() {
        return '';
    }

    static get AUTH_HEADER() {
        const token = document.cookie.replace(
          /(?:(?:^|.*;\s*)AuthorizationMemer\s*=\s*([^;]*).*$)|^.*$/,
          '$1'
        );
        return {
            headers: {
                AuthorizationMemer: token,
            }
        };
    }

    static Memes = class {

        static get MEMES_URL() {
            return `${MemerAPI.BASE_URL}/memes`;
        }

        static getUnseenMemes() {
            return axios.get(`${this.MEMES_URL}/unseen`, MemerAPI.AUTH_HEADER);
        }

        static addMeme(meme) {
            return axios.post(`${this.MEMES_URL}`, meme, MemerAPI.AUTH_HEADER);
        }

        static getMeme(id) {
            return axios.get(`${this.MEMES_URL}/${id}`);
        }

        static deleteMeme(id) {
            axios.delete(`${this.MEMES_URL}/${id}`);
        }

        static upvote(id) {

            const params = {
                "meme_id": id
            }

            return axios.post(`${this.MEMES_URL}/upvote`, params, MemerAPI.AUTH_HEADER);
        }

        static downvote(id) {

            const params = {
                "meme_id": id
            }

            return axios.post(`${this.MEMES_URL}/downvote`, params, MemerAPI.AUTH_HEADER);
        }

        static comment(comment, id) {

            const params = {
                "content": comment
            }

            return axios.post(`${this.MEMES_URL}/${id}/comment`, params, MemerAPI.AUTH_HEADER);
        }

    }

    static User = class {

        static get USERS_URL() {
            return `${MemerAPI.BASE_URL}/users`;
        }

        static signup(name, email, password) {

            const params = {
                "name": name,
                "email": email,
                "password": password
            }

            return axios.post(`${MemerAPI.BASE_URL}/signup`, params);
        }

        static login(email, password) {

            const params = {
                "email": email,
                "password": password
            }

            return axios.post(`${MemerAPI.BASE_URL}/login`, params);
        }

        static autocomplete_username(input) {

            const params = {
                "input": input,
                "limit": 10
            }

            return axios.post(`${MemerAPI.User.USERS_URL}/autocomplete`, params);
        }

        static getMyAccount() {
            return axios.get(`/myaccount`, MemerAPI.AUTH_HEADER);
        }

        static getUserProfile(username) {

            const params = {
                "username": username
            }
            return axios.post(`${MemerAPI.User.USERS_URL}/userprofile`, params, MemerAPI.AUTH_HEADER);

        }

        static followUser(username) {
            const params = {
                "username": username
            }

            return axios.post(`${MemerAPI.User.USERS_URL}/follow`, params, MemerAPI.AUTH_HEADER);
        }

        static async validateToken() {
            return await axios.get(`/validateToken`, MemerAPI.AUTH_HEADER);
        }

    }
}