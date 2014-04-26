class HomeController < ApplicationController
  def index
  end

  def upload_to_wiki
    Word.delay.upload_to_wiki
    redirect_to root_path
  end
end
