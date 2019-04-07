from flask import Flask
from flask import request
from flask import Response
from flask import jsonify

import json

from handlers.handler import Handler
from services.repository import Repository
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
                return Response(status=400)

            content = json.loads(request.json)
            name = content.name
            email = content.email
            password = content.password
            self.user_service.create_user(name, email, password)
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
            content = json.loads(request.json)
            email = content.email
            password = content.password

            token = self.user_service.create_user_token(email, password)
            if token is None:
                return Response(status=401)
            else:
                response = {"token": token}
                return jsonify(response)

        @self.app.route('/users/<int:user_id>', methods=['GET'])
        def get_user(user_id):
            """
            Get user at user_id
            :param user_id: user user_id
            :return: user
            """
            raise NotImplementedError

        # TODO need to be the same user
        @self.app.route('/users/<int:user_id>', methods=['DELETE'])
        def delete_user(user_id):
            """
            Delete user at user_id
            :param user_id: user user_id
            :return: user
            """
            raise NotImplementedError

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
