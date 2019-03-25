
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


@app.route('/')
def index() -> str:
    res = memes()
    random_meme = random.choice(res)
    return render_template('image_meme.html', url = random_meme[1], title = random_meme[0] )


if __name__ == '__main__':
    app.run(host='0.0.0.0')
