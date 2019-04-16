import datetime
import sys

from mysql.connector import MySQLConnection, IntegrityError

from entities.comment import Comment
from entities.meme import Meme
from entities.user import User
from services.repository import Repository
from services.repository_exception import RepositoryException

from flask import jsonify


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
        return User(res[0], res[1], res[2], res[3], res[4], res[5])

    def get_user(self, user_id):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Users u 
                   WHERE u.id=%s"""
        cursor.execute(query, (user_id,))
        res = cursor.fetchall()
        user = self._res_to_user(res[0])
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
        return self._res_to_user(user_info)

    def autocomplete_username(self, name_input, limit):
        cursor = self.db_connection.cursor()
        sql = """
                SELECT u.id, u.username FROM Users u
                WHERE u.username LIKE %s
                LIMIT %s
             """

        val = (('%' + name_input + '%'), int(limit))
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

    def get_user_uploadedmemes(self, user_id):
        cursor = self.db_connection.cursor()
        sql = """
                        SELECT * FROM Memes m
                        WHERE m.id IN (SELECT u.memeId FROM Uploaded u 
                        WHERE u.userId = %s)
                     """
        val = (user_id,)

        cursor.execute(sql, val)
        memes_tuple = cursor.fetchall()
        memes = self._res_to_memes(memes_tuple)
        return memes

    def get_user_likes(self, user_id):
        cursor = self.db_connection.cursor()
        sql = """
                                SELECT COUNT(*) FROM Liked l
                                WHERE l.userId = %s
                             """
        val = (user_id,)

        cursor.execute(sql, val)

        return str(cursor.fetchone()[0])

    def get_user_follows(self, user_id):
        cursor = self.db_connection.cursor()
        sql = """
                                        SELECT COUNT(*) FROM Liked l
                                        WHERE l.userId = %s
                                     """
        val = (user_id,)

        cursor.execute(sql, val)

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

        try:
            cursor.execute(sql, val)
        except:
            raise RepositoryException

        memes_tuples = cursor.fetchall()
        memes = self._res_to_memes(memes_tuples)
        return memes

    def _res_to_memes(self, memes_tuples):
        memes = []
        for meme_tuple in memes_tuples:
            meme = self.tuple_to_meme(meme_tuple)
            meme.comments = self.get_meme_comment(meme.id)
            memes.append(meme)
        return memes

    def get_meme_comment(self, meme_id):
        cursor = self.db_connection.cursor()
        query = """SELECT * 
                   FROM Comment u
                   WHERE u.memeId=%s"""
        val = (meme_id,)
        try:
            cursor.execute(query, val)
        except Exception as e:
            print(e, file=sys.stderr)
            raise RepositoryException
        comments = [self._tuple_to_comment(c) for c in cursor.fetchall()]
        return comments

    def _tuple_to_comment(self, c):
        comment_id = c[0]
        user_id = c[1]
        meme_id = c[2]
        date = c[3]
        text = c[4]

        cursor = self.db_connection.cursor()
        query = """SELECT u.username
                   FROM Users u
                   WHERE u.id=%s"""
        val = (user_id,)
        try:
            cursor.execute(query, val)
            user_name = cursor.fetchall()[0][0]
        except Exception as e:
            print(e, file=sys.stderr)
            raise RepositoryException

        return Comment(text, date, comment_id, user_name, user_id, meme_id)

    @staticmethod
    def tuple_to_meme(meme_tuple) -> Meme:
        return Meme(meme_tuple[0], meme_tuple[1], meme_tuple[2], meme_tuple[3])

    def add_meme(self, user: User, meme: Meme, date):
        cursor = self.db_connection.cursor()

        user_id = user.id

        sql = "INSERT INTO Memes (id, title, url, category) VALUES (%s, %s, %s, %s)"
        val = (meme.id, meme.title, meme.url, meme.category)
        cursor.execute(sql, val)

        sql = "INSERT INTO Uploaded (userId, memeId, date) VALUES (%s, %s, %s)"
        val = (user_id, meme.id, date)

        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException

        self.db_connection.commit()

    def remove_meme(self, meme_id):
        cursor = self.db_connection.cursor()
        sql = "DELETE FROM Memes WHERE id = %s"
        val = (meme_id,)
        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException
        self.db_connection.commit()

    def upvote_meme(self, user: User, meme_id):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Liked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException
        self.db_connection.commit()

    def downvote_meme(self, user: User, meme_id):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Disliked (userId, memeId) VALUES(%s, %s)"
        val = (user_id, meme_id)
        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException
        self.db_connection.commit()

    def seen_meme(self, user: User, meme_id, date):
        cursor = self.db_connection.cursor()
        user_id = user.id
        sql = "INSERT INTO Seen (userId, memeId, date) VALUES(%s, %s, %s)"
        val = (user_id, meme_id, date)
        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException
        self.db_connection.commit()

    def comment_meme(self, comment: Comment):
        cursor = self.db_connection.cursor()
        user_id = comment.user_id
        meme_id = comment.meme_id
        sql = "INSERT INTO Comment (commentId, userId, memeId , date, text) VALUES(%s, %s, %s, %s, %s)"
        val = (comment.id, user_id, meme_id, comment.date, comment.text)
        try:
            cursor.execute(sql, val)
        except Exception:
            raise RepositoryException
        self.db_connection.commit()

    def is_username_free(self, username):
        cursor = self.db_connection.cursor()
        sql = "SELECT COUNT(*) FROM Users u WHERE u.username = %s"
        params = (username,)
        try:
            cursor.execute(sql, params)
        except Exception:
            raise RepositoryException
        return cursor.fetchone()[0] == 0

    def is_email_free(self, email):
        cursor = self.db_connection.cursor()
        sql = "SELECT COUNT(*) FROM Users u WHERE u.email = %s"
        params = (email,)
        try:
            cursor.execute(sql, params)
        except Exception:
            raise RepositoryException
        return cursor.fetchone()[0] == 0
