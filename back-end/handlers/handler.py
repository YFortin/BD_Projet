from functools import wraps
from abc import ABC, abstractmethod
from flask import request, abort
import sys

from services.repository import Repository


class Handler(ABC):
    def __init__(self, repository: Repository):
        self._repository = repository

    @abstractmethod
    def register_routes(self):
        ...

    def authenticate_user(self):
        token = request.cookies.get('token')
        user = self._repository.get_user_from_token(token)
        return user

    def login_required(self, route):
        # inspired from http://flask.pocoo.org/docs/0.12/patterns/viewdecorators/
        # and https://stackoverflow.com/questions/34495632/how-to-implement-login-required-decorator-in-flask
        @wraps(route)
        def function(*args, **kwargs):
            if 'AuthorizationMemer' not in request.headers:
                print("Not in resquest.headers", file=sys.stderr)
                abort(401)
            token = request.headers['AuthorizationMemer']
            user = self._repository.get_user_from_token(token)
            if user is None:
                print(f'user is: {user}', file=sys.stderr)
                abort(401)
            return route(user, *args, **kwargs)

        return function
