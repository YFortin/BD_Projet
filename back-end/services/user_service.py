from services import Repository


class UserService:
    def __init__(self, repository: Repository):
        self.repository = repository
