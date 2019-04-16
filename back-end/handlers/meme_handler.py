from flask import Flask
from flask import request
from flask import Response
from flask import jsonify
import sys

import json

from entities.user import User
from handlers.handler import Handler
from services.meme_service import MemeService
from services.repository import Repository


class MemeHandler(Handler):

    DEFAULT_LIMIT = 10
    DEFAULT_OFFSET = 0

    def __init__(self, app: Flask, meme_service: MemeService, repository: Repository):
        super().__init__(repository)
        self.app = app
        self.meme_service = meme_service

    def register_routes(self):
        @self.app.route('/memes/unseen', methods=['GET'])
        @self.login_required
        def get_memes_unseen(user):
            """
            Get memes
            {
                limit (optional)
            }
            :return: array of memes
            """
            content = json.loads(request.data)
            limit = content.get('limit', self.DEFAULT_LIMIT)

            memes = self.meme_service.get_unseen_meme(user, limit)
            return jsonify([m.__dict__ for m in memes])

        @self.app.route('/memes/<meme_id>', methods=['DELETE'])
        def delete_meme(meme_id):
            """
            Delete meme with meme_id
            :param meme_id: meme meme_id
            :return:
            """
            self.meme_service.delete_meme(meme_id)
            return Response(status=200)

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

        @self.app.route('/memes', methods=['POST'])
        @self.login_required
        def upload_meme(user):
            """
            Get memes
            JSON input
            {
                title
                url
                category
            }
            :return:
            """
            content = json.loads(request.data)
            title = content['title']
            url = content['url']
            category = content['category']

            self.meme_service.upload_meme(user, title, url, category)
            return Response(status=201)

        @self.app.route('/memes/<meme_id>/upvote', methods=['POST'])
        @self.login_required
        def upvote_meme(user: User, meme_id):
            """
            Upvote the meme
            :param user: user
            :param meme_id: meme meme_id
            JSON input
            {

            }
            :return:
            """
            self.meme_service.upvote_meme(user, meme_id)
            return Response(status=200)

        @self.app.route('/memes/<meme_id>/downvote', methods=['POST'])
        @self.login_required
        def downvote_meme(user, meme_id):
            """
            Downvote the meme
            :param user: user
            :param meme_id: meme meme_id
            JSON input
            {

            }
            :return:
            """
            self.meme_service.downvote_meme(user, meme_id)
            return Response(status=200)

        @self.app.route('/memes/<meme_id>/comment', methods=['POST'])
        @self.login_required
        def comment_meme(user, meme_id):
            """
            Comment the meme
            JSON input
            {
                contents:
            }
            :param user: user
            :param meme_id: meme meme_id
            :return:
            """
            content = json.loads(request.data)
            text = content['contents']

            self.meme_service.comment_meme(user, meme_id, text)

            return Response(status=201)
