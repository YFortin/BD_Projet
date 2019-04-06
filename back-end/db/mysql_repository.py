from mysql.connector import MySQLConnection

from entities.meme import Meme
from entities.user import User
from services.repository import Repository


class MySQLRepository(Repository):
    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def get_user(self, user_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Users u WHERE u.id={user_id}')
        res = cursor.fetchall();
        user = User(res.id, res.username, res.email, res.hashedPassword, res.salt)
        return user

    def get_all_users(self):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Users u')
        cursor.fetchall()
        users = []
        for user in cursor:
            users.insert(User(user.id, user.username, user.email, user.hashedPassword, user.salt))
        return users

    def add_user(self, user: User):
        cursor = self.db_connection.cursor()
        cursor.execute(f'INSERT INTO Users VALUES ({user})')

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
