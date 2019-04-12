import datetime
from abc import ABC, abstractmethod

from entities.user import User
from entities.meme import Meme


class Repository(ABC):
    @abstractmethod
    def get_user(self, user_id):
        ...

    @abstractmethod
    def get_all_users(self):
        ...

    @abstractmethod
    def add_user(self, user: User):
        ...

    @abstractmethod
    def edit_user(self, user: User):
        ...

    @abstractmethod
    def remove_user(self, user_id):
        ...

    @abstractmethod
    def get_meme(self, meme_id):
        ...

    @abstractmethod
    def get_all_memes(self):
        ...

    @abstractmethod
    def add_meme(self, user: User, meme: Meme, date: datetime.datetime):
        ...

    @abstractmethod
    def edit_meme(self, meme: Meme):
        ...

    @abstractmethod
    def remove_meme(self, meme_id):
        ...

    @abstractmethod
    def get_user_with_email(self, email):
        ...

    @abstractmethod
    def get_user_from_token(self, token):
        ...

    @abstractmethod
    def add_token(self, user, token):
        ...

    @abstractmethod
    def upvote_meme(self, user: User, meme_id):
        ...

    @abstractmethod
    def downvote_meme(self, user: User, meme_id):
        ...

    @abstractmethod
    def comment_meme(self, user: User, meme_id, date, text):
        ...

    @abstractmethod
    def seen_meme(self, user: User, meme_id, date):
        ...

    @abstractmethod
    def get_unseen_memes(self, user: User, limit):
        ...

    @abstractmethod
    def get_user_id_with_token(self, token):
        ...
