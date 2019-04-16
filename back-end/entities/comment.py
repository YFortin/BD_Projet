class Comment:
    def __init__(self, text, date, comment_id, user_id, meme_id):
        self.id = comment_id
        self.user_id = user_id
        self.meme_id = meme_id
        self.text = text
        self.date = date
