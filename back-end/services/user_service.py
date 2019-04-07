import hashlib
import uuid

from entities.user import User
from services.repository import Repository
from entities.user import User


class UserService:
    def __init__(self, repository: Repository):
        self.repository = repository

    def create_user(self, name, email, password):
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha512(password + salt).hexdigest()

        user_id = uuid.uuid4()
        new_user = User(user_id, name, email, hashed_password, salt)
        self.repository.add_user(new_user)

    def get_user_if_credentials_valid(self, email, password):
        user = self.repository.get_user_with_email(email)
        salt = user.salt
        hashed_password = hashlib.sha512(password + salt).hexdigest()

        if user.hashed_password == hashed_password:
            return user
        else:
            return None

    def create_user_token(self, email, password):
        user = self.user_service.get_user_if_credentials_valid(email, password)
        if user is None:
            return None

        token = uuid.uuid4()
        self.repository.add_token(user, token)
        return token
