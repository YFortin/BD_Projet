import sys
import time

import mysql.connector
from flask import Flask
from flask_cors import CORS
from gevent import monkey
from gevent.pywsgi import WSGIServer

from apscheduler.schedulers.background import BackgroundScheduler
import atexit

from db.mysql_repository import MySQLRepository
from handlers.meme_handler import MemeHandler
from handlers.user_handler import UserHandler
from services.meme_service import MemeService
from services.user_service import UserService

monkey.patch_all()


def connect_to_database() -> MySQLRepository:
    database_config = {
        'user': 'memer_api',
        'password': '4215Hello!@',
        'host': 'db',
        'port': '3306',
        'database': 'Memer'
    }
    database_connection = mysql.connector.connect(**database_config)
    return MySQLRepository(database_connection)


app = Flask(__name__)
CORS(app)


@app.route('/')
def index():
    return 'Memer API'


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

# Remove expired token periodically
print('setting up scheduler', file=sys.stderr)
scheduler = BackgroundScheduler()
scheduler.add_job(lambda: repository.delete_old_token(), trigger='interval', seconds=5)
scheduler.start()
atexit.register(lambda: scheduler.shutdown())

print(__name__)

if __name__ == '__main__':
    print(f"Listening")
    # app.run('0.0.0.0')
    http = WSGIServer(('', 5000), app)
    http.serve_forever()
