from flask import Flask, Response, request, jsonify, abort

from handlers.handler import Handler
from services.repository import Repository
from services.repository_exception import RepositoryException
from services.user_service import UserService


class UserHandler(Handler):
    def __init__(self, app: Flask, user_service: UserService, repository: Repository):
        super().__init__(repository)
        self.app = app
        self.user_service = user_service

    def register_routes(self):
        @self.app.route('/checkUserName', methods=['POST'])
        def check_username():
            """
            Check if username is valid
            :return: if username is free
            Input
            {
                username
            }
            output
            {
                is_free
            }
            """
            if not request.is_json:
                abort(400)

            content = request.json

            try:
                username = content['username']
                is_free = self.user_service.check_username(username)
                return jsonify({'is_free': is_free})
            except Exception:
                abort(400)

        @self.app.route('/checkEmail', methods=['POST'])
        def check_email():
            """
            Check if username is valid
            :return: if username is free
            Input
            {
                email
            }
            output
            {
                is_free
            }
            """
            if not request.is_json:
                abort(400)

            content = request.json

            try:
                email = content['email']
                is_free = self.user_service.check_email(email)
                return jsonify({'is_free': is_free})
            except Exception:
                abort(400)

        @self.app.route('/signup', methods=['POST'])
        def signup():
            """
            Create a new user
            Input:
            {
                name
                email
                password
            }
            Output
            400 if bbad json
            201 if created
            :return:
            """
            if not request.is_json:
                abort(400)

            content = request.json

            try:
                name = content['name']
                email = content['email']
                password = content['password']
            except Exception:
                abort(400)

            try:
                self.user_service.create_user(name, email, password)
            except RepositoryException:
                abort(400)
            return Response(status=201)

        @self.app.route('/login', methods=['POST'])
        def login():
            """
            log the user if the email-password pair is correct
            Input:
            {
                email
                password
            }
            Output
            400 if bbad json
            200 and
            {
                token
            }
            :return: Set token cookie in client
            """
            if not request.is_json:
                abort(400)

            content = request.json

            try:
                email = content['email']
                password = content['password']
            except Exception:
                abort(400)

            token = self.user_service.create_user_token(email, password)
            if token is None:
                abort(401)
            else:
                response = {"token": token}
                return jsonify(response)

        @self.app.route('/validateToken', methods=['GET'])
        def validate_token():
            user = self.get_user_if_authenticated()

            response = {'valid': user is not None}

            return jsonify(response)

        @self.app.route('/users/<user_id>', methods=['GET'])
        def get_user(user_id):
            """
            Get user at user_id
            :param user_id: user user_id
            :return: user
            """

            user = self.user_service.get_user_at_id(user_id)
            user_json = {'id': user.id, 'username': user.name, 'avatar': user.avatar, 'email': user.email}

            return jsonify(user_json)

        @self.app.route('/users', methods=['DELETE'])
        @self.login_required
        def delete_user(user):
            """
            Delete user at user_id
            :param user: user
            :return: user
            """
            raise NotImplementedError

        @self.app.route('/myaccount', methods=['GET'])
        @self.login_required
        def get_my_user(user):
            """
            Return my user
            :return: user
            """
            result = {'id': user.id, 'username': user.name, 'avatar': user.avatar, 'email': user.email}
            return jsonify(result)

        @self.app.route('/users/userprofile', methods=['POST'])
        @self.login_required
        def get_userprofile_by_username(user):
            """
            Input:
            {
                "username" = "" : string
            }
            :return: userprofile
            """

            content = request.json
            username = content['username']
            user_id = self.user_service.get_userid_with_username(username)
            is_follow = self.user_service.i_am_following(user.id, user_id)
            nb_follows = self.user_service.get_user_follows(user_id)
            nb_likes = self.user_service.get_user_likes(user_id)
            user = self.user_service.get_user_at_id(user_id)
            memes = self.user_service.get_user_uploadedmemes(user_id)
            memes_tuples = []

            for meme in memes:
                comments = []
                for comment in meme.comments:
                    commentResult = {'id': comment.id, 'user_id': comment.user_id, 'meme_id': comment.meme_id,
                                     'text': comment.text, 'date': comment.date, 'user_name': comment.user_name}
                    comments.append(commentResult)

                result = {'id': meme.id, 'title': meme.title, 'url': meme.url, 'category': meme.category,
                          'comments': comments}
                memes_tuples.append(result)

            userprofile = {'username': user.name, 'avatar': user.avatar, 'followers': nb_follows,
                           'following': is_follow, 'likes': nb_likes,
                           'memes': memes_tuples}
            return jsonify(userprofile)

        @self.app.route('/myaccount', methods=['POST'])
        @self.login_required
        def update_my_account(user):
            """
            update
            :return:
            {
                username
                email
                password (empty to not change it)
                avatar
            }
            """
            if not request.is_json:
                abort(400)

            content = request.json

            try:
                username = content['username']
                email = content['email']
                password = content['password']
                avatar = content['avatar']
            except Exception:
                abort(400)

            self.user_service.update_user(user, username, email, password, avatar)

        @self.app.route('/users/follow', methods=['POST'])
        @self.login_required
        def follow_user(user):
            """
            The current user unfollow the user with user_id
           {
               username = "" : string
           }
           :return:
           """
            content = request.json
            username = content['username']
            user_id = self.user_service.get_userid_with_username(username)
            self.user_service.follow(user.id, user_id)

            return Response(status=200)

        @self.app.route('/users/autocomplete', methods=['POST'])
        def autocomplete_username():
            """
            Autocomplete username
            Input:
            {
                "input" = "" : string
                "limit" = "" : string
            }
            Output
            {
            List of
                userId
                username
            }
            """

            try:
                content = request.json
                name_input = content['input']
                limit = content['limit']
                res = self.user_service.autocomplete_username(name_input, limit)
                a = []
                for x in res:
                    a.append({'id': x[0], 'username': x[1]})

                results = {'results': a}
            except:
                abort(400)

            return jsonify(results)
