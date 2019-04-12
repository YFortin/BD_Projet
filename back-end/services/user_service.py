import hashlib
import uuid
from typing import Optional
import sys

from services.repository import Repository
from entities.user import User


class UserService:
    def __init__(self, repository: Repository):
        self.repository = repository

    def create_user(self, name, email, password):
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

        user_id = uuid.uuid4()
        new_user = User(user_id, name, email, hashed_password, salt)

        print(f'when signup: {new_user.__dict__}', file=sys.stderr)
        print(f'when signup hash: {hashed_password}', file=sys.stderr)
        print(f'when signup salt: {salt}', file=sys.stderr)

        self.repository.add_user(new_user)

    def get_user_if_credentials_valid(self, email, password) -> Optional[User]:
        user = self.repository.get_user_with_email(email)

        if user is None:
            return None
        salt = user.salt
        hashed_password = hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

        print(f'user: {user.__dict__}', file=sys.stderr)
        print(f'user.ads: {user.hashed_password}', file=sys.stderr)
        print(f'new hash: {hashed_password}', file=sys.stderr)
        print(f'salt: {salt}', file=sys.stderr)

        if user.hashed_password == hashed_password:
            return user
        else:
            print('password is invalid', file=sys.stderr)
            return None

    def create_user_token(self, email, password):
        user = self.get_user_if_credentials_valid(email, password)
        print(f'user: {user}', file=sys.stderr)
        if user is None:
            return None

        token = uuid.uuid4()
        self.repository.add_token(user, token)
        return token
