class User:
    def __init__(self, id, name, email, hashedPassword, salt):
        self._id = id
        self._name = name
        self._email = email
        self._hashedPassword = hashedPassword
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
    def hashedPassword(self):
        return

    @hashedPassword.setter
    def hashedPassword(self, value):
        self.hashedPassword = value

    @property
    def salt(self):
        return

    @salt.setter
    def salt(self, value):
        self._salt = value
