from flask import Flask
from flask import request
from flask import Response
from flask import jsonify

import json

from handlers.handler import Handler
from services.meme_service import MemeService
from services.repository import Repository
from services.user_service import UserService


class MemeHandler(Handler):
    def __init__(self, app: Flask, meme_service: MemeService, repository: Repository):
        super().__init__(repository)
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
            content = json.loads(request.data)
            limit = content['limit']
            offset = content['offset']

            memes = self.meme_service.get_memes(limit, offset)
            return jsonify(memes)

        @self.app.route('/memes/unseen', methods=['GET'])
        def get_memes():
            """
            Get memes
            {
                "limit" = "" : string
            }
            :return: array of memes
            """
            content = json.loads(request.data)
            limit = content['limit']

            memes = self.meme_service.get_unseen_meme(limit)
            return jsonify(memes)

        @self.app.route('/memes/<meme_id>', methods=['GET'])
        def get_meme_at(meme_id):
            """
            Return the meme with meme_id
            :param meme_id: meme meme_id
            :return: meme
            """
            meme = self.meme_service.get_meme(meme_id)
            return jsonify(meme)

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

        @self.app.route('/memes/new', methods=['GET'])
        def get_new_memes():
            """
            Get newest memes
            Query params:
                limit -> maximum number of memes to return
                offset -> return memes starting at offset
            :return: array of memes
            """
            content = json.loads(request.json)
            raise NotImplementedError

        @self.app.route('/memes', methods=['POST'])
        def upload_meme():
            """
            Get memes
            JSON input
            {
                "title": "" :: string
                "url": "" :: string
                "category": "" :: string
                "token: "" :: string
            }
            :return:
            """
            content = json.loads(request.data)
            title = content['title']
            url = content['url']
            category = content['category']
            token = content['token']

            self.meme_service.upload_meme(title, url, category, token)
            return Response(status=201)

        @self.app.route('/memes/<meme_id>/upvote', methods=['POST'])
        def upvote_meme(meme_id):
            """
            Upvote the meme
            :param meme_id: meme meme_id
            JSON input
            {
                "token" : "" :: string
            }
            :return:
            """
            content = json.loads(request.data)
            token = content['token']
            self.meme_service.upvote_meme(meme_id, token)
            return Response(status=200)

        @self.app.route('/memes/<meme_id>/downvote', methods=['POST'])
        def downvote_meme(meme_id):
            """
            Downvote the meme
            :param meme_id: meme meme_id
            JSON input
            {
                "token" : "" :: string
            }
            :return:
            """
            content = json.loads(request.data)
            token = content['token']

            self.meme_service.downvote_meme(meme_id, token)
            return Response(status=200)

        @self.app.route('/memes/<meme_id>/comment', methods=['POST'])
        def comment_meme(meme_id):
            """
            Comment the meme
            JSON input
            {
                user_id:
                contents:
            }
            :param meme_id: meme meme_id
            :return:
            """
            content = json.loads(request.data)
            text = content['contents']
            token = content['token']

            self.meme_service.comment_meme(token, meme_id, text)

            return Response(status=201)
