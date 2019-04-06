from services.repository import Repository


class MemeService:
    def __init__(self, repository: Repository):
        self.repository = repository

    def get_memes(self,limit,offset):
        all_memes = self.repository.get_all_memes()

        memes=[]

        for x in range(offset,offset+limit):
            memes.append(all_memes[x])

        return memes

    def get_meme(self,meme_id):
        return self.repository.get_meme(meme_id)

    def delete_meme(self,meme_id):
        self.repository.remove_meme(meme_id)