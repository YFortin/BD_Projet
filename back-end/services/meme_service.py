from services import Repository


class MemeService:
    def __init__(self, repository: Repository):
        self.repository = repository
