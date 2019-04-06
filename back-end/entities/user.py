class User:
    def __init__(self, uid, name, email, hashed_password, salt):
        self._id = uid
        self._name = name
        self._email = email
        self._hashed_password = hashed_password
        self._salt = salt

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, value):
        self._id = value

    @property
    def name(self):
        return

    @name.setter
    def name(self, value):
        pass

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = value

    @property
    def hashed_password(self):
        return

    @hashed_password.setter
    def hashed_password(self, value):
        self.hashed_password = value

    @property
    def salt(self):
        return

    @salt.setter
    def salt(self, value):
        self._salt = value
