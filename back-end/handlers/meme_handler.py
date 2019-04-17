from flask import Flask, abort
from flask import request
from flask import Response
from flask import jsonify

import json

from handlers.handler import Handler
from services.meme_service import MemeService
from services.repository import Repository
from services.repository_exception import RepositoryException


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
            if not request.is_json:
                limit = self.DEFAULT_LIMIT
            else:
                content = json.loads(request.data)
                limit = content.get('limit', self.DEFAULT_LIMIT)

            try:
                memes = self.meme_service.get_unseen_meme(user, limit)

                results = []

                for meme in memes:
                    comments = []
                    for comment in meme.comments:
                        commentResult = {'id': comment.id, 'user_id': comment.user_id, 'meme_id': comment.meme_id,
                                         'text': comment.text, 'date': comment.date, 'user_name': comment.user_name}
                        comments.append(commentResult)

                    result = {'id': meme.id, 'title': meme.title, 'url': meme.url, 'category': meme.category,
                              'comments': comments}
                    results.append(result)
                return jsonify({'unseen_memes': results})
            except RepositoryException:
                abort(401)

        @self.app.route('/memes/<meme_id>', methods=['DELETE'])
        def delete_meme(meme_id):
            """
            Delete meme with meme_id
            :param meme_id: meme meme_id
            :return:
            """
            try:
                self.meme_service.delete_meme(meme_id)
            except RepositoryException:
                abort(404)
            return Response(status=200)

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
            if not request.is_json:
                abort(400)

            content = json.loads(request.data)

            if 'title' not in content or 'url' not in content or 'category' not in content:
                abort(400)

            title = content['title']
            url = content['url']
            category = content['category']

            self.meme_service.upload_meme(user, title, url, category)
            return Response(status=201)

        @self.app.route('/memes/upvote', methods=['POST'])
        @self.login_required
        def upvote_meme(user):
            """
            Upvote the meme
            :param user: user
            JSON input
            {
                "meme_id = "" :string
            }
            :return:
            """
            try:
                content = request.json
                meme_id = content['meme_id']

                self.meme_service.upvote_meme(user, meme_id)
            except RepositoryException:
                abort(404)
            return Response(status=200)

        @self.app.route('/memes/downvote', methods=['POST'])
        @self.login_required
        def downvote_meme(user):
            """
            Downvote the meme
            :param user: user
            JSON input
            {
                "meme_id = "" :string
            }
            :return:
            """
            try:
                content = request.json
                meme_id = content['meme_id']
                self.meme_service.downvote_meme(user, meme_id)
            except RepositoryException:
                abort(404)
            return Response(status=200)

        @self.app.route('/memes/comment', methods=['POST'])
        @self.login_required
        def comment_meme(user):
            """
            Comment the meme
            JSON input
            {
                contents:
            }
            :param user: user
            Json
            {
                meme_id = "" : string
            }
            :return:
            """
            if not request.is_json:
                abort(400)

            content = json.loads(request.data)

            if 'contents' not in content:
                abort(400)

            text = content['contents']
            meme_id = content['meme_id']

            self.meme_service.comment_meme(user, meme_id, text)

            return Response(status=201)

            @self.app.route('/top', methods=['GET'])
            @self.login_required
            def get_top_meme(user):
                """
                get top meme
                :return: top meme
                """
            memes = self.meme_service.get_top_memes()

            results = []

            for meme in memes:
                comments = []
                for comment in meme.comments:
                    commentResult = {'id': comment.id, 'user_id': comment.user_id, 'meme_id': comment.meme_id,
                                     'text': comment.text, 'date': comment.date, 'user_name': comment.user_name}
                    comments.append(commentResult)

                result = {'id': meme.id, 'title': meme.title, 'url': meme.url, 'category': meme.category,
                          'comments': comments}
                results.append(result)
            return jsonify({'top_memes': results})

