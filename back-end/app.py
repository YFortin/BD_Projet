from flask import Flask
import mysql.connector

import time

from flask import Flask
from flask_cors import CORS
from gevent.pywsgi import WSGIServer
from gevent import monkey

from services.user_service import UserService
from services.meme_service import MemeService

from handlers.meme_handler import MemeHandler
from handlers.user_handler import UserHandler
from db.mysql_repository import MySQLRepository

monkey.patch_all()


def connect_to_database() -> MySQLRepository:
    database_config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'Memeber'
    }
    database_connection = mysql.connector.connect(**database_config)
    return MySQLRepository(database_connection)


app = Flask(__name__)
CORS(app)


@app.route('/')
def index():
    return 'Memeber API'


while True:
    try:
        repository = connect_to_database()
        print("App is connected")
        break
    except Exception as e:
        print(e)
        time.sleep(5)

user_service = UserService(repository)
user_handler = UserHandler(app, user_service, repository)
user_handler.register_routes()

meme_service = MemeService(repository)
meme_handler = MemeHandler(app, meme_service, repository)
meme_handler.register_routes()

# Create admin

user_service.create_user('admin', 'admin@admin', 'root')
user_service.create_admin_token('6c26bf90-172d-433c-a8b4-dbc4c62edf62')

print(__name__)

if __name__ == '__main__':
    print(f"Listening")
    app.run('0.0.0.0')
    # http = WSGIServer(('', 5000), app)
    # http.serve_forever()
