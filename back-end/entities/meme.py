class Meme:
    def __init__(self, meme_id, title, url, category):
        self.id = meme_id
        self.title = title
        self.url = url
        self.category = category
        self.comments = []
