import axios from 'axios';

export default class MemerAPI {
    static get BASE_URL() {
        return 'http://localhost:5000'
    }

    static userId = 'not set';

    static Memes = class {

        static get MEMES_URL() {
            return `${MemerAPI.BASE_URL}/memes`;
        }

        static getAll() {
            return axios.get(`${this.MEMES_URL}`);
        }

        static addMeme(meme) {
            return axios.post(`${this.MEMES_URL}`, meme);
        }

        static getMeme(id) {
            return axios.get(`${this.MEMES_URL}/${id}`);
        }

        static deleteMeme(id) {
            axios.delete(`${this.MEMES_URL}/${id}`);
        }

        static upvote(id) {
            return axios.post(`${this.MEMES_URL}/${id}/upvote`, this.userId);
        }

        static downvote(id) {
            return axios.post(`${this.MEMES_URL}/${id}/downvote`, this.userId);
        }

        static comment(comment, id) {
            
            const params = {
                userId: this.userId,
                contents: comment 
            }

            return axios.post(`${this.MEMES_URL}/${id}/comment`, params);
        }

    }

    static User = class {

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

    }
}