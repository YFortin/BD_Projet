import datetime

from mysql.connector import MySQLConnection

from entities.meme import Meme
from entities.user import User
from services.repository import Repository


class MySQLRepository(Repository):

    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def add_token(self, user, token):
        user_id = user.id
        expire_date = datetime.datetime.now() + datetime.timedelta(days=1)
        cursor = self.db_connection.cursor()
        cursor.execute(f'INSERT INTO Token VALUES ({user})')  # todo fixme

    def _datetime_to_str(self, date: datetime.datetime):
        return date.date().isoformat()

    def add_user(self, user: User):
        cursor = self.db_connection.cursor()
        cursor.execute(f'INSERT INTO Users VALUES ({user})')  # fixme todo

    def get_user_from_token(self, token):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT u '
                       f'FROM Users u, Token t'
                       f'WHERE u.id=t.userId AND t.token={token}')
        res = cursor.fetchall()
        user = User(res.id, res.username, res.email, res.hashed_password, res.salt)
        return user

    def get_user(self, user_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Users u WHERE u.id={user_id}')
        res = cursor.fetchall()
        user = User(res.id, res.username, res.email, res.hashed_password, res.salt)
        return user

    def get_user_with_email(self, email):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Users u WHERE u.email={email}')
        res = cursor.fetchall()
        user = User(res.id, res.username, res.email, res.hashed_password, res.salt)
        return user

    def get_all_users(self):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Users u')
        cursor.fetchall()
        users = []
        for user in cursor:
            users.insert(User(user.id, user.username, user.email, user.hashed_password, user.salt))
        return users

    def edit_user(self, user: User):
        cursor = self.db_connection.cursor()
        cursor.execute(f'UPDATE Users u SET VALUES({user}) WHERE u.id = {user.id}')

    def remove_user(self, user_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'DELETE Users u WHERE u.ud = {user_id}')

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
