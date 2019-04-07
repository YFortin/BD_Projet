import datetime
from abc import ABC, abstractmethod
from uuid import UUID

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
    def add_meme(self, meme: Meme, user_id: UUID, date:datetime.datetime):
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
    def upvote_meme(self, meme_id, user_id, date):
        ...

    @abstractmethod
    def downvote_meme(self,meme_id, user_id, date):
        ...

    @abstractmethod
    def comment_meme(self, comment_id, meme_id, user_id, date, text):
        ...
