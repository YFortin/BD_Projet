import hashlib
import uuid
from typing import Optional

from entities.user import User
from services.repository import Repository


class UserService:
    DEFAULT_USER_AVATAR = 'https://banner2.kisspng.com/20180722/gfc/kisspng-user-profile-2018-in-sight-user-conference-expo-5b554c0968c377.0307553315323166814291.jpg'

    def __init__(self, repository: Repository):
        self.repository = repository

    def create_user(self, name, email, password):
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

        user_id = uuid.uuid4()
        new_user = User(user_id, name, self.DEFAULT_USER_AVATAR, email, hashed_password, salt)

        self.repository.add_user(new_user)

    def get_user_if_credentials_valid(self, email, password) -> Optional[User]:
        user = self.repository.get_user_with_email(email)

        if user is None:
            return None
        salt = user.salt
        hashed_password = hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

        if user.hashed_password == hashed_password:
            return user
        else:
            return None

    def get_user_at_id(self, user_Id):

        user = self.repository.get_user(user_Id)

        return user

    def create_user_token(self, email, password):
        user = self.get_user_if_credentials_valid(email, password)
        if user is None:
            return None

        token = uuid.uuid4()
        self.repository.add_token(user, token)
        return token

    def autocomplete_username(self, name_input, limit):
        return self.repository.autocomplete_username(name_input, limit)

    def get_user_by_id(self, user_id):
        return self.repository.get_user(user_id)

    def get_userprofile_by_id(self, user_id):
        self.repository.get_user(user_id)
        self.repository.get_user_uploadedmemes(user_id)
        self.repository.get_user_likes(user_id)
