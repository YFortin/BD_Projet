from flask import Flask

from handlers.handler import Handler
from services.user_service import UserService


class UserHandler(Handler):
    def __init__(self, app: Flask, user_service: UserService):
        self.app = app
        self.user_service = user_service


    def register_routes(self):
        @self.app.route('/signup', methods=['POST'])
        def signup():
            """
            Create a new user
            :return:
            """
            raise NotImplementedError

        @self.app.route('/login', methods=['POST'])
        def login():
            """
            log the user if the email-password pair is correct
            :return: Set token cookie in client
            """
            raise NotImplementedError

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
