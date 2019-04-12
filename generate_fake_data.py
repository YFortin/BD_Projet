import argparse
import random
import uuid
import lorem
import datetime

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

num_user = 100
user_ids = []
for i in range(num_user):
	id = uuid.uuid4()
	user_ids.append(id)
	username = lorem.sentence().split()[0]
	email = lorem.sentence().split()[0]
	hashedPassword = random.randint(0, 1000)
	salt = random.randint(0, 1000)
	file.write(f'INSERT INTO Users (id, username, email, hashedPassword, salt) VALUES ("{id}", "{username}", "{email}", "{hashedPassword}", "{salt}");\n')

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
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	file.write(f'INSERT INTO Top (memeId, date) VALUES ("{memeId}", "{date}");\n')

file.close()





