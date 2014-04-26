class Word < ActiveRecord::Base
  scope :uploadable, ->{ where(:uploaded_to_wiki => false, :existing_in_wiki => false) } 

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
      str += "\n" + "{{விளக்கம்}} " + word.description + "\n" + "மொழிபெயர்ப்புகள்" + "<br />" + "{{ஆங்கிலம்}} -" + " - " + word.pronunciation
    end
    str
  end
end
