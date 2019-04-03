from mysql.connector import MySQLConnection

from entities import Meme
from entities import User
from services import Repository


class MySQLRepository(Repository):
    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def _user_tuple_to_user(self, data):
        raise NotImplementedError()

    def get_user(self, user_id):
        raise NotImplementedError()

    def get_all_users(self):
        raise NotImplementedError()

    def add_user(self, user: User):
        raise NotImplementedError()

    def edit_user(self, user: User):
        raise NotImplementedError()

    def remove_user(self, user_id):
        raise NotImplementedError()

    def get_meme(self, meme_id):
        raise NotImplementedError()

    def get_all_memes(self):
        raise NotImplementedError()

    def add_meme(self, meme: Meme):
        raise NotImplementedError()

    def edit_meme(self, meme: Meme):
        raise NotImplementedError

    def remove_meme(self, meme_id):
        raise NotImplementedError()
