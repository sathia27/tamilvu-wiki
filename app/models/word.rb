require 'media_wiki'
class Word < ActiveRecord::Base
  scope :uploadable, ->{ where(:uploaded_to_wiki => false) } 

  def self.upload_to_wiki
    tamilvu = MediaWiki::Gateway.new("http://ta.wiktionary.org/w/api.php")
    tamilvu.login("sathia27", "sathia44")
    uploadable.each do |word|
      puts "Uploading word #{word.name} to wikipedia"
      Uploader::Wiki.new(word, tamilvu).create
    end
  end
end
