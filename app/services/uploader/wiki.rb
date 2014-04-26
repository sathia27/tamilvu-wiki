require 'media_wiki'
class Uploader::Wiki
  def initialize word
    @word = word
    @tamilvu = MediaWiki::Gateway.new("http://ta.wiktionary.org/w/api.php")
    @tamilvu.login("sathia27", "sathia44")
  end

  def exists?
    @tamilvu.get(@word.name) ? true : false
  end

  def create
    if exists?
      @word.existing_in_wiki = true
      @word.save
    else
      @tamilvu.create(@word.name, @word.description)
      @word.uploaded_to_wiki = true
      @word.save
    end
  end
end
