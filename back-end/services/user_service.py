from services.repository import Repository
from entities.user import User


class UserService:
    def __init__(self, repository: Repository):
        self.repository = repository
        admin = User('1', 'admin', 'admin@admin', '123', '45')
        self.repository.init_user_admin(admin)
