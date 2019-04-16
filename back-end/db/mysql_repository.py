import datetime
import sys

from mysql.connector import MySQLConnection, IntegrityError

from entities.comment import Comment
from entities.meme import Meme
from entities.user import User
from services.repository import Repository

from services.repository_exception import RepositoryException


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
        self.db_connection.commit()

    @staticmethod
    def _datetime_to_str(date: datetime.datetime):
        return date.date().isoformat()

    def get_user_from_token(self, token):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u
                   WHERE u.id IN (SELECT t.userId FROM Token t
                   WHERE t.token=%s)"""
        val = (token,)
        cursor.execute(query, val)
        res = cursor.fetchall()
        user = self.tuple_to_user(res[0])
        return user

    @staticmethod
    def tuple_to_user(res):
        return User(res[0], res[1], res[2], res[3], res[4], res[5])

    @staticmethod
    def _res_to_user(res):
        return User(res.id, res.username, res.avatar, res.email, res.hashed_password, res.salt)

    def get_user(self, user_id):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u 
                   WHERE u.id=%s"""
        cursor.execute(query, user_id)
        res = cursor.fetchall()
        user = self._res_to_user(res)
        return user

    def get_user_with_email(self, email):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u 
                   WHERE u.email=%s"""
        val = (email,)
        cursor.execute(query, val)
        res = cursor.fetchall()
        if len(res) == 0:
            return None
        user_info = res[0]
        return User(user_info[0], user_info[1], user_info[2], user_info[3], user_info[4], user_info[5])

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

    def add_user(self, user: User):
        cursor = self.db_connection.cursor()
        query = 'INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES (%s, %s, %s, %s, %s)'
        data_tuple = str(user.id), user.name, user.email, user.hashed_password, user.salt
        try:
            cursor.execute(query, data_tuple)
        except IntegrityError:
            raise RepositoryException()
        self.db_connection.commit()

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

    def get_unseen_memes(self, user: User, limit: int):
        cursor = self.db_connection.cursor()
        user_id = user.id

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
        memes_tuples = cursor.fetchall()
        memes = []
        for meme_tuple in memes_tuples:
            memes.append(self.tuple_to_meme(meme_tuple))

        return memes

    @staticmethod
    def tuple_to_meme(meme_tuple):
        return Meme(meme_tuple[0], meme_tuple[1], meme_tuple[2], meme_tuple[3])

    # user: User, meme: Meme, token: uuid, date:datetime.datetime
    def add_meme(self, user: User, meme: Meme, date):
        cursor = self.db_connection.cursor()

        user_id = user.id

        sql = "INSERT INTO Memes (id, title, url, category) VALUES (%s, %s, %s, %s)"
        val = (meme.id, meme.title, meme.url, meme.category)
        cursor.execute(sql, val)

        sql = "INSERT INTO Uploaded (userId, memeId, date) VALUES (%s, %s, %s)"
        val = (user_id, meme.id, date)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def remove_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        sql = "DELETE FROM Memes WHERE id = %s"
        val = (meme_id,)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def upvote_meme(self, user: User, meme_id):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Liked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def downvote_meme(self, user: User, meme_id):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Disliked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def seen_meme(self, user: User, meme_id, date):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Seen (userId, memeId, date) VALUES(%s, %s, %s)"
        val = (user_id, meme_id, date)
        cursor.execute(sql, val)
        self.db_connection.commit()

    def comment_meme(self, user: User, meme_id, comment: Comment, date, text):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Comment (commentId, userId, memeId , date, text) VALUES(%s, %s, %s, %s, %s)"
        val = (comment.id, user_id, meme_id, date, comment.text)
        cursor.execute(sql, val)
        self.db_connection.commit()

