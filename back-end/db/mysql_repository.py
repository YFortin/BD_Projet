from mysql.connector import MySQLConnection

from entities.meme import Meme
from entities.user import User
from services.repository import Repository


class MySQLRepository(Repository):
    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def get_user(self, user_id):
        self.db_connection.ex
        raise NotImplementedError

    def get_all_users(self):
        raise NotImplementedError

    def add_user(self, user: User):
        raise NotImplementedError

    def edit_user(self, user: User):
        raise NotImplementedError

    def remove_user(self, user_id):
        raise NotImplementedError

    def get_meme(self, meme_id):
        raise NotImplementedError

    def get_all_memes(self):
        raise NotImplementedError

    def add_meme(self, meme: Meme):
        raise NotImplementedError

    def edit_meme(self, meme: Meme):
        raise NotImplementedError

    def remove_meme(self, meme_id):
        raise NotImplementedError
