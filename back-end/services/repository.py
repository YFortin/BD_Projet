from abc import ABC, abstractmethod


class Repository(ABC):
    @abstractmethod
    def get_user(self, user_id):
        ...

    @abstractmethod
    def get_all_users(self):
        ...

    @abstractmethod
    def add_user(self, user):
        ...

    @abstractmethod
    def edit_user(self, user):
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
    def add_meme(self, user):
        ...

    @abstractmethod
    def edit_meme(self, user):
        ...

    @abstractmethod
    def remove_meme(self, user_id):
        ...
