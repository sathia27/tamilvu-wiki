require 'nokogiri'
require 'open-uri'
class Tamilvu

  words = []
  page_start = 1
  page_end = 1
  f = File.open("tamilvu/tamilvu-#{page_start}.csv", "a")
  (page_start..page_end).each do |page_no|
    puts page_no.to_s
    page = Nokogiri::HTML(open("http://www.tamilvu.org/slet/servlet/lexpg?pageno=#{page_no.to_s}"))
    page.search("td[width='100'] font").each do |word|
      word.css("sup").remove
      tam_word = word.text.strip
      if (!tam_word.eql?(""))
        f.write(tam_word+"\n")
      end
    end
  end

end