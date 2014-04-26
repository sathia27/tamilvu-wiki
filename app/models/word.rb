class Word < ActiveRecord::Base
  scope :uploadable, ->{ where(:uploaded_to_wiki => false, :existing_in_wiki => false) }
  scope :uploaded_to_wiki, ->{ where(:uploaded_to_wiki => true) }
  scope :existing_in_wiki, ->{ where(:existing_in_wiki => true) }

  has_many :word_details

  def self.upload_to_wiki
    tamilvu = MediaWiki::Gateway.new("http://ta.wiktionary.org/w/api.php")
    tamilvu.login("sathia27", "sathia44")
    uploadable.each do |word|
      puts "Uploading word #{word.name} to wikipedia"
      Uploader::Wiki.new(word, tamilvu).create
    end
  end


  def wiki_string
    str = ""
    word_details.each do |word|
      str += "\n" + "{{விளக்கம்}} " + word.description + "\n" + "{{மொழிபெயர்ப்புகள்}}" + "\n" + "{{ஆங்கிலம்}} -" + " - " + word.pronunciation
    end
    str
  end
end
