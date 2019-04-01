from mysql.connector import MySQLConnection

from services.repository import Repository


class MySQLRepository(Repository):
    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def get_user(self, user_id):
        raise NotImplementedError

    def get_all_users(self):
        raise NotImplementedError

    def add_user(self, user):
        raise NotImplementedError

    def edit_user(self, user):
        raise NotImplementedError

    def remove_user(self, user_id):
        raise NotImplementedError

    def get_meme(self, meme_id):
        raise NotImplementedError

    def get_all_memes(self):
        raise NotImplementedError

    def add_meme(self, user):
        raise NotImplementedError

    def edit_meme(self, user):
        raise NotImplementedError

    def remove_meme(self, user_id):
        raise NotImplementedError
