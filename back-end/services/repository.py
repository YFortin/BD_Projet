import datetime
from abc import ABC, abstractmethod

from entities.comment import Comment
from entities.user import User
from entities.meme import Meme


class Repository(ABC):
    @abstractmethod
    def get_user(self, user_id):
        ...

    @abstractmethod
    def add_user(self, user: User):
        ...

    @abstractmethod
    def edit_user(self, user: User):
        ...

    @abstractmethod
    def remove_user(self, user_id):
        ...

    @abstractmethod
    def add_meme(self, user: User, meme: Meme, date: datetime.datetime):
        ...

    @abstractmethod
    def remove_meme(self, meme_id):
        ...

    @abstractmethod
    def get_user_with_email(self, email):
        ...

    @abstractmethod
    def get_user_from_token(self, token):
        ...

    @abstractmethod
    def get_userid_with_username(self, username):
        ...

    @abstractmethod
    def add_token(self, user, token):
        ...

    @abstractmethod
    def upvote_meme(self, user: User, meme_id):
        ...

    @abstractmethod
    def downvote_meme(self, user: User, meme_id):
        ...

    @abstractmethod
    def comment_meme(self, comment: Comment):
        ...

    @abstractmethod
    def seen_meme(self, user: User, meme_id, date):
        ...

    @abstractmethod
    def get_unseen_memes(self, user: User, limit):
        ...

    @abstractmethod
    def autocomplete_username(self, name_input, limit):
        ...

    @abstractmethod
    def get_meme_comment(self, meme: Meme):
        ...

    @abstractmethod
    def get_user_uploadedmemes(self, user_id):
        ...

    def get_user_follows(self, user_id):
        ...

    @abstractmethod
    def get_user_likes(self, user_id):
        ...

    @abstractmethod
    def is_username_free(self, username):
        ...

    @abstractmethod
    def is_email_free(self, email):
        ...

    @abstractmethod
    def is_following(self, user_id_follower, user_id_followee):
        ...

    @abstractmethod
    def follow(self, user_id_follower, user_id_followee):
        ...

    @abstractmethod
    def unfollow(self, user_id_follower, user_id_followee):
        ...

    @abstractmethod
    def delete_old_token(self):
        ...
