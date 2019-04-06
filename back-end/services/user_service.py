import hashlib
import uuid

from entities.user import User
from services.repository import Repository


class UserService:
    def __init__(self, repository: Repository):
        self.repository = repository

    def create_user(self, name, email, password):
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha512(password + salt).hexdigest()

        user_id = uuid.uuid4()
        new_user = User(user_id, name, email, hashed_password, salt)
        self.repository.add_user(new_user)

    def are_credential_valid(self, email, password):
        user = self.repository.get_user_with_email(email)
        salt = user.salt
        hashed_password = hashlib.sha512(password + salt).hexdigest()

        return user.hashed_password == hashed_password

    def create_user_token(self, user):
        token = uuid.uuid4()
        self.repository.add_token(user, token)

