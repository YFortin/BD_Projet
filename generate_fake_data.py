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

file.write("""INSERT INTO Memes (id, title, url, category) 
VALUES""")

num_memes = 200
meme_ids = []
for i in range(num_memes):
	id = uuid.uuid4()
	meme_ids.append(id)
	title = lorem.sentence()
	url = random.choice(memes_urls)
	category = random.choice(memes_categories)
	file.write(f'("{id}", "{title}", "{url}", "{category}")')
	if i != num_memes - 1:
		file.write(',\n')
file.write(';\n\n')

# insert User
file.write("""INSERT INTO Users (id, username, email, hashedPassword, salt) 
VALUES""")

num_user = 100
user_ids = []
for i in range(num_user):
	id = uuid.uuid4()
	user_ids.append(id)
	username = lorem.sentence().split()[0]
	email = lorem.sentence().split()[0]
	hashedPassword = random.randint(0, 1000)
	salt = random.randint(0, 1000)
	file.write(f'("{id}", "{username}", "{email}", "{hashedPassword}", "{salt}")')
	if i != num_user - 1:
		file.write(',\n')
file.write(';\n\n')

# Generate follow
file.write("""INSERT INTO Follow (followee, follower) 
VALUES""")
num_follow = 200
for i in range(num_follow):
	followee = random.choice(user_ids)
	follower = random.choice(user_ids)
	file.write(f'("{followee}", "{follower}")')
	if i != num_follow - 1:
		file.write(',\n')
file.write(';\n\n')

# Seen
file.write("""INSERT INTO Seen (userId, memeId, date) 
VALUES""")
num_seen = 200
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	file.write(f'("{userId}", "{memeId}", "{date}")')
	if i != num_seen - 1:
		file.write(',\n')
file.write(';\n\n')

# Liked
file.write("""INSERT INTO Liked (userId, memeId) 
VALUES""")
num_liked = 200
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	file.write(f'("{userId}", "{memeId}")')
	if i != num_liked - 1:
		file.write(',\n')
file.write(';\n\n')

# Disliked
file.write("""INSERT INTO Disliked (userId, memeId) 
VALUES""")
num_disliked = 200
for i in range(num_follow):
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	file.write(f'("{userId}", "{memeId}")')
	if i != num_disliked - 1:
		file.write(',\n')
file.write(';\n\n')

# Uploaded
file.write("""INSERT INTO Uploaded (userId, memeId) 
VALUES""")
for i, memeId in enumerate(meme_ids):
	userId = random.choice(user_ids)
	file.write(f'("{userId}", "{memeId}")')
	if i != num_memes - 1:
		file.write(',\n')
file.write(';\n\n')

# Comment
file.write("""INSERT INTO Comment (commentId, userId, memeId, date, text) 
VALUES""")
num_comment = 250
for i in range(num_comment):
	commentId = uuid.uuid4()
	userId = random.choice(user_ids)
	memeId = random.choice(meme_ids)
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	text = lorem.sentence()
	file.write(f'("{commentId}", "{userId}", "{memeId}", "{date}", "{text}")')
	if i != num_comment - 1:
		file.write(',\n')
file.write(';\n\n')

# Token
file.write("""INSERT INTO Token (userId, token, expiredDate) 
VALUES""")
num_token = 100
for i in range(num_token):
	userId = random.choice(user_ids)
	token = uuid.uuid4()
	expiredDate = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 30))).date().isoformat()
	
	file.write(f'("{userId}", "{token}", "{expiredDate}")')
	if i != num_token - 1:
		file.write(',\n')
file.write(';\n\n')

# Top
file.write("""INSERT INTO Top (memeId, date) 
VALUES""")
num_top = 100
for i in range(num_top):
	userId = random.choice(user_ids)
	date = (datetime.datetime.now() + datetime.timedelta(days=-random.randint(0, 1000))).date().isoformat()
	file.write(f'("{userId}", "{date}")')
	if i != num_top - 1:
		file.write(',\n')
file.write(';\n\n')

file.close()





