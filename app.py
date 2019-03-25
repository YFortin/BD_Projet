from flask import Flask, render_template
from json import loads
from mysql.connector import connect
from mysql.connector.cursor import MySQLCursor
import requests
import random

application = Flask('glo2005')


host = "192.168.99.100"
port = "1337"
username = "root"
password = None
database_name = "memeber"

database_connector = connect(
    host=host, port=port, user=username, password=password)

cursor = database_connector.cursor()
cursor.execute("CREATE DATABASE memeber")

database_connector = connect(
    host=host, port=port, user=username, password=password, database=database_name)

cursor = database_connector.cursor()


cursor.execute("use memeber")
cursor.execute("drop table IF EXISTS memes")
cursor.execute("""create table memes(	
	name varchar(100),
	url varchar(100),
	fid numeric(3,0) primary key
)""")

cursor.execute("""INSERT INTO memes(name, url, fid)
               VALUES
               ("no gaz", "https://img-9gag-fun.9cache.com/photo/aKxewzj_700bwp.webp", 0),
               ("Probably the happiest guy alive right now <3",
                "https://img-9gag-fun.9cache.com/photo/a1QV4Wb_700bwp.webp", 1),
               ("How to avoid being kidnapped",
                "https://img-9gag-fun.9cache.com/photo/aB0GRgz_460svvp9.webm", 2),
               ("Playgrounds are rough",
                "https://img-9gag-fun.9cache.com/photo/apmbE0B_460svvp9.webm", 3),
               ("Choo-Choo, motherf**kers!",
                "https://img-9gag-fun.9cache.com/photo/a2Z2EOE_460svvp9.webm", 4),
               ("That subtle marble thigh softness",
                "https://img-9gag-fun.9cache.com/photo/an9EeR5_700bwp.webp", 5),
               ("2019 be like", "https://img-9gag-fun.9cache.com/photo/a6O2rgR_700bwp.webp", 6),
               ("American Political Parties",
                "https://img-9gag-fun.9cache.com/photo/a739m9b_460swp.webp", 7),
               ("Sometimes I just can't stand her",
                "https://img-9gag-fun.9cache.com/photo/a739m9b_460swp.webp", 8),
               ("Think about it, Google ",
                "https://img-9gag-fun.9cache.com/photo/aB0EMG2_460swp.webp", 9)
               """)

cursor.commit()


def new_meme():
    rand = random.randint(0, 10)
    query = "SELECT DISTINCT S.Sname FROM Memes M WHERE M.fid = rand"


@application.route('/')
def index():
    return "<a href=/chien>photo de chien</a>"


@application.route('/chien')
def photo_de_chien():
    reponse_api_photo_chien = requests.get(URL_API_PHOTO_CHIEN)
    json_de_lapi = loads(reponse_api_photo_chien.text)
    json_de_lapi["message"]

    return render_template('image_animal.html', url=json_de_lapi["message"], animal="chien")


application.run('0.0.0.0', 8000)
