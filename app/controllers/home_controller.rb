class HomeController < ApplicationController
  def index
    @word_count = Word.count
    @wiki_tamilvu = Word.existing_in_wiki.count
    @words_uploaded = Word.uploaded_to_wiki.count
  end

  def upload_to_wiki
    Word.delay.upload_to_wiki
    redirect_to root_path
  end

  def scrap_from_tamilvu
    scrapping = Scrapper::Tamilvu.new
    scrapping.delay.start
    redirect_to root_path
  end

  def words
    @words = Word.all
  end
end
