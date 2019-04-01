from services.user_service import UserService
from services.meme_service import MemeService

from handlers.meme_handler import MemeHandler
from handlers.user_handler import UserHandler
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

repository = connect_to_database()

user_service = UserService(repository)
user_handler = UserHandler(app, user_service)
user_handler.register_routes()

meme_service = MemeService(repository)
meme_handler = MemeHandler(app, meme_service)
meme_handler.register_routes()

if __name__ == '__main__':
    app.run(host='0.0.0.0')
