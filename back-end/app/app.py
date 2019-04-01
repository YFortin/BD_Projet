from flask import Flask, render_template
import mysql.connector
import json
import random

app = Flask(__name__)


def memes():
    config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'memeber'
    }
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM memes')
    results = cursor.fetchall()
    cursor.close()
    connection.close()

    return results


@app.route('/signup', methods=['POST'])
def signup():
    """
    Create a new user
    :return:
    """
    raise NotImplementedError


@app.route('/login', methods=['POST'])
def login():
    """
    log the user if the email-password pair is correct
    :return: Set token cookie in client
    """
    raise NotImplementedError


@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    """
    Get user at id
    :param id: user id
    :return: user
    """
    raise NotImplementedError


# TODO need to be the same user
@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    """
    Delete user at id
    :param id: user id
    :return: user
    """
    raise NotImplementedError


@app.route('/users/<int:id>/follow', methods=['POST'])
def follow_user(id):
    """
    The current user follow the user with id
    :param id: user to follow id
    :return:
    """
    raise NotImplementedError


@app.route('/users/<int:id>/unfollow', methods=['POST'])
def unfollow_user(id):
    """
    The current user unfollow the user with id
    :param id: user to unfollow id
    :return:
    """
    raise NotImplementedError


@app.route('/memes', methods=['GET'])
def get_memes():
    """
    Get memes
    Query params:
        limit -> maximum number of memes to return
        offset -> return memes starting at offset
    :return: array of memes
    """
    raise NotImplementedError


@app.route('/memes/<int:id>', methods=['GET'])
def get_meme_at_id(id):
    """
    Return to meme with id
    :param id: meme id
    :return: meme
    """
    raise NotImplementedError


@app.route('/memes/<int:id>', methods=['DELETE'])
def delete_meme_at_id(id):
    """
    Delete meme with id
    :param id: meme id
    :return:
    """
    raise NotImplementedError


@app.route('/memes/top', methods=['GET'])
def get_top_memes():
    """
    Get top memes
    Query params:
        limit -> maximum number of memes to return
        offset -> return memes starting at offset
    :return: array of memes
    """
    raise NotImplementedError


@app.route('/memes/new', methods=['GET'])
def get_new_memes():
    """
    Get newest memes
    Query params:
        limit -> maximum number of memes to return
        offset -> return memes starting at offset
    :return: array of memes
    """
    raise NotImplementedError


@app.route('/memes', methods=['POST'])
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


@app.route('/memes/<int:id>/upvote', methods=['POST'])
def upvote_a_meme(id):
    """
    Upvote the meme
    :param id: meme id
    :return:
    """
    raise NotImplementedError


@app.route('/memes/<int:id>/downvote', methods=['POST'])
def downvote_a_meme(id):
    """
    Downvote the meme
    :param id: meme id
    :return:
    """
    raise NotImplementedError


@app.route('/memes/<int:id>/comment', methods=['POST'])
def comment_a_meme(id):
    """
    Comment the meme
    JSON input
    {
        contents:
    }
    :param id: meme id
    :return:
    """
    raise NotImplementedError


if __name__ == '__main__':
    app.run(host='0.0.0.0')
