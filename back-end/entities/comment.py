class Comment:
    def __init__(self, comment_id, username, comment, date):
        self._comment_id = comment_id
        self._username = username
        self._comment = comment
        self._date = date

    @property
    def comment_id(self):
        return self._comment_id

    @comment_id.setter
    def comment_id(self, value):
        self._comment_id = value

    @property
    def username(self):
        return self._username

    @username.setter
    def username(self, value):
        self._username = value

    @property
    def comment(self):
        return self._comment

    @comment.setter
    def add_comment(self, value):
        self._comment.append(value)

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, value):
        self._date = value
