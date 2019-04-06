from abc import ABC, abstractmethod
from flask import request

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
