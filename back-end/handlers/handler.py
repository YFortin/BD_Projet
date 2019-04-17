from abc import ABC, abstractmethod
from functools import wraps

from flask import request, abort

from services.repository import Repository

import sys


class Handler(ABC):
    def __init__(self, repository: Repository):
        self._repository = repository

    @abstractmethod
    def register_routes(self):
        ...

    def login_required(self, route):
        # inspired from http://flask.pocoo.org/docs/0.12/patterns/viewdecorators/
        # and https://stackoverflow.com/questions/34495632/how-to-implement-login-required-decorator-in-flask
        @wraps(route)
        def function(*args, **kwargs):
            user = self.get_user_if_authenticated()
            if user is not None:
                return route(user, *args, **kwargs)
            else:
                return abort(401)
        return function

    def get_user_if_authenticated(self):

        if 'AuthorizationMemer' not in request.headers:
            print('header not present', file=sys.stderr)
            return None
        token = request.headers['AuthorizationMemer']
        user = self._repository.get_user_from_token(token)
        if user is None:
            print('User is none', file=sys.stderr)
            return None

        return user
