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
    def add_meme(self, meme: Meme):
        ...

    @abstractmethod
    def edit_meme(self, meme: Meme):
        ...

    @abstractmethod
    def remove_meme(self, meme_id):
        ...

    @abstractmethod
    def init_user_admin(self, user: User):
        ...

    def upvote_meme(self, meme_id, user_id, date):
        ...

    @abstractmethod
    def downvote_meme(self,meme_id, user_id, date):
        ...
