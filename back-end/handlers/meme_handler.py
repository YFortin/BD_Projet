from flask import Flask

from handlers import Handler
from services import MemeService


class MemeHandler(Handler):
    def __init__(self, app: Flask, meme_service: MemeService):
        self.app = app
        self.meme_service = meme_service

    def register_routes(self):
        @self.app.route('/memes', methods=['GET'])
        def get_memes():
            """
            Get memes
            Query params:
                limit -> maximum number of memes to return
                offset -> return memes starting at offset
            :return: array of memes
            """
            raise NotImplementedError

        @self.app.route('/memes/<int:meme_id>', methods=['GET'])
        def get_meme_at(meme_id):
            """
            Return to meme with meme_id
            :param meme_id: meme meme_id
            :return: meme
            """
            raise NotImplementedError

        @self.app.route('/memes/<int:meme_id>', methods=['DELETE'])
        def delete_meme(meme_id):
            """
            Delete meme with meme_id
            :param meme_id: meme meme_id
            :return:
            """
            raise NotImplementedError

        @self.app.route('/memes/top', methods=['GET'])
        def get_top_memes():
            """
            Get top memes
            Query params:
                limit -> maximum number of memes to return
                offset -> return memes starting at offset
            :return: array of memes
            """
            raise NotImplementedError

        @self.app.route('/memes/new', methods=['GET'])
        def get_new_memes():
            """
            Get newest memes
            Query params:
                limit -> maximum number of memes to return
                offset -> return memes starting at offset
            :return: array of memes
            """
            raise NotImplementedError

        @self.app.route('/memes', methods=['POST'])
        def upload_meme():
            """
            Get memes
            JSON input
            {
                "url": "" :: string
                "category": "" :: string
            }
            :return:
            """
            raise NotImplementedError

        @self.app.route('/memes/<int:meme_id>/upvote', methods=['POST'])
        def upvote_meme(meme_id):
            """
            Upvote the meme
            :param meme_id: meme meme_id
            :return:
            """
            raise NotImplementedError

        @self.app.route('/memes/<int:meme_id>/downvote', methods=['POST'])
        def downvote_meme(meme_id):
            """
            Downvote the meme
            :param meme_id: meme meme_id
            :return:
            """
            raise NotImplementedError

        @self.app.route('/memes/<int:meme_id>/comment', methods=['POST'])
        def comment_meme(meme_id):
            """
            Comment the meme
            JSON input
            {
                contents:
            }
            :param meme_id: meme meme_id
            :return:
            """
            raise NotImplementedError
