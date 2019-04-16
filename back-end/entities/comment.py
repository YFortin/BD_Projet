class Comment:
    def __init__(self, text, date, comment_id, username, user_id, meme_id):
        self.comment_id = comment_id
        self.username = username
        self.user_id = user_id
        self.meme_id = meme_id
        self.text = text
        self.date = date
