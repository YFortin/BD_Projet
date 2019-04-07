from services.repository import Repository
from entities.meme import Meme

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

    def upload_meme(self, title, url, category, user_id):
        id = str(uuid.uuid4())
        meme = Meme(id, title, url, category)
        date = datetime.datetime.now()
        self.repository.add_meme(meme, user_id, date)

    def upvote_meme(self, meme_id, user_id):
        date = datetime.datetime.now()
        self.repository.upvote_meme(meme_id, user_id, date)

    def downvote_meme(self, meme_id, user_id):
        date = datetime.datetime.now()
        self.repository.downvote_meme(meme_id, user_id, date)
