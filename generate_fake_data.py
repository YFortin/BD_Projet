import argparse
import random
import uuid
import lorem
import datetime
import string

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--output', help='output file', required=True)
args = parser.parse_args()

file = open(args.output, 'w')

# insert Memes
memes_urls = [
	'https://i.redd.it/efks3i9rhtr21.jpg',
	'https://preview.redd.it/bq2j0dw68tr21.png?width=960&crop=smart&auto=webp&s=b490cefdf787c73e562e699adfd961541045e857',
	'https://i.redd.it/f26bi9089ur21.jpg',
	'https://preview.redd.it/tkbusgmmotr21.jpg?width=960&crop=smart&auto=webp&s=131994de6ebdf657687451229853be42b143da2b',
	'https://i.redd.it/3c6sylyabur21.png',
	'https://preview.redd.it/m82pxbpaaur21.jpg?width=640&crop=smart&auto=webp&s=14de48af47c9e10080256a0805e764a8fbca7745',
	'https://i.redd.it/5bcqhjdm1tr21.jpg',
	'https://preview.redd.it/2ya4b0sjbtr21.jpg?width=960&crop=smart&auto=webp&s=fb8d1aa13ccdb73d6b4aa422d9f19b18cc8da05e',
	'https://preview.redd.it/hnikeip39ur21.jpg?width=640&crop=smart&auto=webp&s=72794533a67b87ffeb0fdb525281184da5320a75',
	'https://i.redd.it/aikn8tn0fur21.jpg',
	'https://i.redd.it/7fmda1cpwf421.jpg',
	'https://i.redd.it/00pwop4bjsy11.jpg',
	'https://preview.redd.it/l2wvnktafmi11.jpg?width=960&crop=smart&auto=webp&s=74683b3a070d75d7a12fb5ec63f4717093e7018d',
]

memes_categories = ['dank', 'classic', '2009', 'catz', '2meirl4meirl', 'holdmybeer']

num_memes = 200
meme_ids = []
for i in range(num_memes):
	id = uuid.uuid4()
	meme_ids.append(id)
	title = lorem.sentence()
	url = random.choice(memes_urls)
	category = random.choice(memes_categories)
	file.write(f'INSERT INTO Memes (id, title, url, category) VALUES ("{id}", "{title}", "{url}", "{category}");\n')

# insert User

user_urls = [
	'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/220px-User_icon_2.svg.png',
	'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0WMIMCWCCZ8LxgACZMv3eO441cvSIsUIFH_8aR_e7JGy3UTiJTA',
	'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb2AfQjrtZnNtqy4diFZNyTSH4peeJCqJgIUPvJo5dHSNjcB17',
	'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTgBfhWZBJJNVWvyiyu4ZjtJWtUeJ3nrRcjCIvr0MXlasZmJEw',
	'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVbs4YIhQrBTWQ-1pEj3mhyTOmFL2lVfsS37px81N1s7IazLG_',
	'https://images-na.ssl-images-amazon.com/images/I/51bolC6rJHL.jpg',
	'https://images-na.ssl-images-amazon.com/images/I/413oGxxoL4L._SX425_.jpg',
	'https://cdn.shopify.com/s/files/1/1061/1924/products/Emoji_Icon_-_Smirk_face_large.png?v=1542436013',
	'https://banner2.kisspng.com/20180202/coq/kisspng-smiley-anger-angry-expression-5a74670b4552c0.292907191517577995284.jpg',
	'https://images.alphacoders.com/476/thumb-1920-4761.jpg'
]

num_user = 100
user_ids = []
count = 0
names = ['will', 'yan', 'xavier', 'mpp', 'cpp', 'python', 'bob', 'alice', 'paul', 'hunter', 'patate', 'pomme', 'allo', 'hotdog', 'happy_dude', 
		'sad_dude', 'lorem ispsum', 'mark', 'smiley_bob']
email_hosts = ['hotmail.com', 'gmail.com', 'memer.ca', 'google.com', 'allo.ca', 'abc.uk', 'pfk.eu', 'notreDameDeParis.fr', 'blackHole.void', 'null.null']
for i in range(num_user):
	id = uuid.uuid4()
	user_ids.append(id)
	username = ''.join([random.choice(names), str(count)])
	count += 1
	avatar = random.choice(user_urls)
	# https://stackoverflow.com/questions/2257441/random-string-generation-with-upper-case-letters-and-digits
	email = ''.join([username, '@',random.choice(email_hosts)])
	hashedPassword = random.randint(0, 1000)
	salt = random.randint(0, 1000)
	file.write(f'INSERT INTO Users (id, username, avatar, email, hashedPassword, salt) VALUES ("{id}", "{username}", "{avatar}", "{email}", "{hashedPassword}", "{salt}");\n')

# Generate follow

num_follow = 500
for i in range(num_follow):
	followee = random.choice(user_ids)
	follower = random.choice(user_ids)
	file.write(f'INSERT INTO Follow (followee, follower) VALUES ("{followee}", "{follower}");\n')

# Seen
num_seen = 1000
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	file.write(f'INSERT INTO Seen (userId, memeId, date) VALUES ("{userId}", "{memeId}", "{date}");\n')

# Liked
num_liked = 500
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	file.write(f'INSERT INTO Liked (userId, memeId) VALUES ("{userId}", "{memeId}");\n')

# Disliked
num_disliked = 500
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	file.write(f'INSERT INTO Disliked (userId, memeId) VALUES ("{userId}", "{memeId}");\n')

# Uploaded
for i, memeId in enumerate(meme_ids):
	userId = random.choice(user_ids)
	file.write(f'INSERT INTO Uploaded (userId, memeId) VALUES ("{userId}", "{memeId}");\n')

# Comment
num_comment = 250
for i in range(num_comment):
	commentId = uuid.uuid4()
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	text = lorem.sentence()
	file.write(f'INSERT INTO Comment (commentId, userId, memeId, date, text) VALUES ("{commentId}", "{userId}", "{memeId}", "{date}", "{text}");\n')

# Token
num_token = 100
for i in range(num_token):
	userId = random.choice(user_ids)
	token = uuid.uuid4()
	expiredDate = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 30))).date().isoformat()
	
	file.write(f'INSERT INTO Token (userId, token, expiredDate) VALUES ("{userId}", "{token}", "{expiredDate}");\n')

# Top
num_top = 100
for i in range(num_top):
	memeId = random.choice(meme_ids)
	meme_ids.remove(memeId)
	# date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	file.write(f'INSERT INTO Top (memeId) VALUES ("{memeId}");\n')

file.close()





