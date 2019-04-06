class Meme:
    def __init__(self, id, title, url, category):
        self._id = id
        self._title = title
        self._url = url
        self._category = category

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, value):
        self._id = value

    @property
    def title(self):
        return self._title

    @title.setter
    def title(self, value):
        self._title = value

    @property
    def url(self):
        return self._url

    @url.setter
    def url(self, value):
        self._url = value

    @property
    def category(self):
        return self._category

    @category.setter
    def category(self, value):
        self._category = value
