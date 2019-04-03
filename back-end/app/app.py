from services import UserService
from services import MemeService

from handlers import MemeHandler
from handlers import UserHandler
from db.mysql_repository import MySQLRepository

from flask import Flask
import mysql.connector


def connect_to_database() -> MySQLRepository:
    database_config = {
        'user': 'root',
        'password': 'root',
        'host': 'db',
        'port': '3306',
        'database': 'memeber'
    }
    database_connection = mysql.connector.connect(**database_config)
    return MySQLRepository(database_connection)


app = Flask(__name__)


@app.route('/')
def index():
    return 'Hello, World!'


repository = connect_to_database()

user_service = UserService(repository)
user_handler = UserHandler(app, user_service)
user_handler.register_routes()

meme_service = MemeService(repository)
meme_handler = MemeHandler(app, meme_service)
meme_handler.register_routes()

if __name__ == '__main__':
    app.run('0.0.0.0', 5000)
