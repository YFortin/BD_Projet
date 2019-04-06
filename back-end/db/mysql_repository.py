from mysql.connector import MySQLConnection

from entities.meme import Meme
from entities.user import User
from services.repository import Repository


class MySQLRepository(Repository):
    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def init_user_admin(self, user: User):
        cursor = self.db_connection.cursor()
        sql = "INSERT INTO Users (id, username, email, hashed_password,salt) VALUES (%s, %s, %s, %s, %s)"
        val = (user.id, user.name, user.email, user.hashedPassword, user.salt)
        cursor.execute(sql, val)

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

        sql = "SELECT * FROM Memes m WHERE m.id = %s"
        val = (meme_id,)
        cursor.execute(sql, val)
        return cursor.fetchall()

    def get_all_memes(self):
        cursor = self.db_connection.cursor()
        cursor.execute(f'SELECT * FROM Memes')

        return cursor.fetchall()

    def add_meme(self, meme: Meme, user_id, date):
        cursor = self.db_connection.cursor()
        sql = "INSERT INTO Memes (id, title, url, category) VALUES (%s, %s, %s, %s)"
        val = (meme.id, meme.title, meme.url, meme.category)
        cursor.execute(sql, val)

        sql = "INSERT INTO Uploaded (userId, memeId, date) VALUES (%s, %s, %s)"
        val = (user_id, meme.id, date)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def edit_meme(self, meme: Meme):
        cursor = self.db_connection.cursor()
        cursor.execute(f'UPDATE * FROM Memes m SET VALUES({meme}) WHERE m.id = {meme.id}')

    def remove_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        sql = "DELETE FROM Memes WHERE id = %s"
        val = (meme_id,)
        cursor.execute(sql, val)
        self.db_connection.commit()

