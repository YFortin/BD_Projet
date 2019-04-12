from services.repository import Repository
from entities.meme import Meme
from entities.user import User

import uuid
import datetime


class MemeService:
    def __init__(self, repository: Repository):
        self.repository = repository

    def get_memes(self, limit, offset):
        memes = []
        memes.extend(self.repository.get_all_memes())
        memes = memes[int(offset):int(offset + limit)]

        return memes

    def get_meme(self, meme_id):
        return self.repository.get_meme(meme_id)

    def delete_meme(self, meme_id):
        self.repository.remove_meme(meme_id)

    def upload_meme(self, user, title, url, category):
        meme_id = str(uuid.uuid4())
        meme = Meme(meme_id, title, url, category)
        date = datetime.datetime.now()
        self.repository.add_meme(user, meme, date)

    def upvote_meme(self, user: User, meme_id):
        date = datetime.datetime.now()
        self.repository.seen_meme(user, meme_id, date)
        self.repository.upvote_meme(user, meme_id)

    def downvote_meme(self, meme_id, token):
        date = datetime.datetime.now()
        self.repository.seen_meme(meme_id, token, date)
        self.repository.downvote_meme(meme_id, token)

    def comment_meme(self, user: User, meme_id, text):
        date = datetime.datetime.now()
        meme_id = str(uuid.uuid4())

        self.repository.comment_meme(user, meme_id, date, text)

    def get_unseen_meme(self, user: User, limit: int):
        memes = self.repository.get_unseen_memes(user, limit)
        return memes
