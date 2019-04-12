class User:
    def __init__(self, uid, name, avatar, email, hashed_password, salt):
        self.id = uid
        self.name = name
        self.avatar = avatar
        self.email = email
        self.hashed_password = hashed_password
        self.salt = salt
