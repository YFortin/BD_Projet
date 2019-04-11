import datetime

from mysql.connector import MySQLConnection

from entities.meme import Meme
from entities.user import User
from services.repository import Repository
import random


class MySQLRepository(Repository):

    def __init__(self, connection: MySQLConnection):
        self.db_connection = connection

    def add_token(self, user, token):
        user_id = user.id
        expire_date = self._datetime_to_str(datetime.datetime.now() + datetime.timedelta(days=1))
        cursor = self.db_connection.cursor()

        sql = 'INSERT INTO Token (userId, token, expiredDate) VALUES (%s, %s, %s)'
        val = (user_id, str(token), expire_date)
        cursor.execute(sql, val)

    @staticmethod
    def _datetime_to_str(date: datetime.datetime):
        return date.date().isoformat()

    def get_user_from_token(self, token):
        cursor = self.db_connection.cursor()
        query = """SELECT u 
                   FROM Users u, Token t
                   WHERE u.id=t.userId AND t.token=%s"""
        val = (token,)
        cursor.execute(query, val)
        res = cursor.fetchall()
        user = User(res.id, res.username, res.email, res.hashed_password, res.salt)
        return user

    def get_user(self, user_id):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u 
                   WHERE u.id=%s"""
        cursor.execute(query, user_id)
        res = cursor.fetchall()
        user = User(res.id, res.username, res.email, res.hashed_password, res.salt)
        return user

    def get_user_with_email(self, email):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u 
                   WHERE u.email=%s"""
        val = (email,)
        cursor.execute(query, val)
        res = cursor.fetchall()
        user_info = res[0]
        user = User(user_info[0], user_info[1], user_info[2], user_info[3], user_info[4])
        return user

    def get_all_users(self):
        cursor = self.db_connection.cursor()
        cursor.execute('SELECT * FROM Users u')
        cursor.fetchall()
        users = []
        for user in cursor:
            users.insert(User(user.id, user.username, user.email, user.hashed_password, user.salt))
        return users

    def add_user(self, user: User):
        cursor = self.db_connection.cursor()
        query = 'INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES (%s, %s, %s, %s, %s)'
        data_tuple = str(user.id), user.name, user.email, user.hashed_password, user.salt
        cursor.execute(query, data_tuple)

    def edit_user(self, user: User):
        cursor = self.db_connection.cursor()
        query = """UPDATE Users 
                   SET id = %s, username = %s, email = %s, hashedPassword = %s, salt = %s
                   WHERE u.id = %s"""
        values = (user.id, user.name, user.email, user.hashed_password, user.salt, user.id)
        cursor.execute(query, values)

    def remove_user(self, user_id):
        cursor = self.db_connection.cursor()
        query = """DELETE * FROM Users u WHERE u.id = %s"""
        values = user_id
        cursor.execute(query, values)

    def autocomplete_username(self, input, limit):
        cursor = self.db_connection.cursor()
        sql = """
                SELECT u.id, u.username FROM Users u
                WHERE u.username LIKE %s
                LIMIT %s
             """

        val = (('%' + input + '%'), int(limit))
        cursor.execute(sql, val)
        return cursor.fetchall()

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

    def get_unseen_memes(self, limit, token):
        cursor = self.db_connection.cursor()
        user_id = self.get_userId_with_token(token)

        sql = """SELECT * FROM Memes m
                 WHERE 1 > (
                 SELECT COUNT(*) FROM Seen s
                 WHERE s.memeId = m.id AND s.userId = %s
                 )
                 ORDER BY RAND()
                 LIMIT %s
              """
        val = (user_id, int(limit))

        cursor.execute(sql, val)
        return cursor.fetchall()

    def add_meme(self, meme: Meme, token, date):
        cursor = self.db_connection.cursor()

        user_id = self.get_userId_with_token(token)

        sql = "INSERT INTO Memes (id, title, url, category) VALUES (%s, %s, %s, %s)"
        val = (meme.id, meme.title, meme.url, meme.category)
        cursor.execute(sql, val)

        sql = "INSERT INTO Uploaded (userId, memeId, date) VALUES (%s, %s, %s)"
        val = (user_id, meme.id, date)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def edit_meme(self, meme: Meme):
        cursor = self.db_connection.cursor()
        query = """UPDATE Users 
                   SET id = %s, title = %s, url = %s, category = %s
                   WHERE m.id = %s"""
        values = (meme.id, meme.title, meme.url, meme.category)
        cursor.execute(query, values)

    def remove_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        sql = "DELETE FROM Memes WHERE id = %s"
        val = (meme_id,)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def upvote_meme(self, meme_id, token):
        cursor = self.db_connection.cursor()
        user_id = self.get_userId_with_token(token)
        sql = "INSERT INTO Liked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        cursor.execute(sql, val)

    def downvote_meme(self, meme_id, token):
        cursor = self.db_connection.cursor()
        user_id = self.get_userId_with_token(token)
        sql = "INSERT INTO Disliked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        cursor.execute(sql, val)

    def seen_meme(self, meme_id, token, date):
        cursor = self.db_connection.cursor()
        user_id = self.get_userId_with_token(token)
        sql = "INSERT INTO Seen (userId, memeId, date) VALUES(%s, %s, %s)"
        val = (user_id, meme_id, date)
        cursor.execute(sql, val)

    def comment_meme(self, comment_id, meme_id, token, date, text):
        cursor = self.db_connection.cursor()
        user_id = self.get_userId_with_token(token)
        sql = "INSERT INTO Comment (commentId, userId, memeId , date, text) VALUES(%s, %s, %s, %s, %s)"
        val = (comment_id, user_id, meme_id, date, text)
        cursor.execute(sql, val)

    def get_userId_with_token(self, token):
        cursorToken = self.db_connection.cursor()
        sql = "SELECT * FROM Token t WHERE t.token = %s"
        val = (token,)
        cursorToken.execute(sql, val)

        response = cursorToken.fetchall()
        token_response = response[0]
        user_id = token_response[1]
        return user_id

    def get_number_element_in_a_table(self, table):
        cursor = self.db_connection.cursor()
        sql = "SELECT COUNT(*) FROM %s"
        val = (table,)

        cursor.execute(sql, val)
        res = cursor.fetchall()
        return int(res[0])
