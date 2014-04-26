class HomeController < ApplicationController
  def index
  end

  def upload_to_wiki
    Word.delay.upload_to_wiki
    redirect_to root_path
  end

  def scrap_from_tamilvu
    Scrapper::Tamilvu.new.delay.start
    redirect_to root_path
  end
end
