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
        cursor.execute(
            f'INSERT INTO Users VALUES ({user.id,},{user.name},{user.email},{user.hashedPassword},{user.salt})')

    def edit_user(self, user: User):
        cursor = self.db_connection.cursor()
        cursor.execute(f'UPDATE * FROM Users u SET VALUES({user}) WHERE u.id = {user.id}')

    def remove_user(self, user_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'DELETE * FROM Users u WHERE u.ud = {user_id}')

    def get_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Memes m WHERE m.md = {meme_id}')

    def get_all_memes(self):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Memes m')

    def add_meme(self, meme: Meme):
        cursor = self.db_connection.cursor()
        cursor.execute(f'UPDATE * FROM Memes m SET VALUES({meme}) WHERE m.id = {meme.id}')

    def edit_meme(self, meme: Meme):
        cursor = self.db_connection.cursor()
        cursor.execute(f'UPDATE * FROM Memes m SET VALUES({meme}) WHERE m.id = {meme.id}')

    def remove_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        cursor.execute(f'DELETE * FROM Memes m WHERE m.ud = {meme_id}')
