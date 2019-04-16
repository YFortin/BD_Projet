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
            # TODO try catch
            name = content['name']
            email = content['email']
            password = content['password']

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
            content = request.json
            email = content['email']
            password = content['password']

            token = self.user_service.create_user_token(email, password)
            if token is None:
                abort(401)
            else:
                response = {"token": token}
                return jsonify(response)

        @self.app.route('/validateToken', methods=['GET'])
        @self.login_required
        def validate_token(_):
            return Response(status=200)

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

        # TODO need to be the same user
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
            result = {'id': user.id, 'username': user.name, 'avatar': user.name, 'email': user.email}
            return jsonify(result)

        @self.app.route('/users/<int:user_id>/follow', methods=['POST'])
        def follow_user(user_id):
            """
            The current user follow the user with user_id
            :param user_id: user to follow user_id
            :return:
            """
            raise NotImplementedError

        @self.app.route('/users/<int:user_id>/unfollow', methods=['POST'])
        def unfollow_user(user_id):
            """
            The current user unfollow the user with user_id
            :param user_id: user to unfollow user_id
            :return:
            """
            raise NotImplementedError

        @self.app.route('/users/autocomplete', methods=['GET'])
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
            content = request.json
            name_input = content['input']
            limit = content['limit']
            res = self.user_service.autocomplete_username(name_input, limit)
            a = []
            for x in res:
                a.append({'id': x[0], 'username': x[1]})

            results = {'results': a}

            return jsonify(results)
