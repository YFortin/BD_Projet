from abc import ABC, abstractmethod


class Handler(ABC):
    @abstractmethod
    def register_routes(self):
        ...
