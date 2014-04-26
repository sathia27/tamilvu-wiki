require 'open-uri'
class Scrapper::Tamilvu

  def initialize
    @page_start = 1
    @page_end = 1
  end

  def start
    (@page_start..@page_end).each do |page_no|
      puts page_no.to_s
      page = Nokogiri::HTML(open("http://www.tamilvu.org/slet/servlet/lexpg?pageno=#{page_no.to_s}"))
      puts "Found #{page.css("tr[bgcolor='ivory']").count} words"
      page.css("tr[bgcolor='ivory']").each do |word|
        word.css('sup').remove
        puts "Processing #{word}"
        begin
          pos = Pos.find_or_create_by(name: word.css('td')[1].children[2].text)
          w = Word.create(name: word.css('td')[0].text.gsub("\n", '').gsub("\r", ''))
          detail = WordDetail.find_or_create_by(word_id: w.id, pos_id: pos.id)
          tag = word.css('td')[1]
          detail.pronunciation = tag.children[0].text
          detail.parts_of_speech = tag.children[2].text
          detail.description = tag.children[3..-1].text.gsub(/[0-9]+[\.|\s]/, "\n#")
          w.save!
          detail.save!
        rescue => e
          puts e.inspect
        end
      end
    end
  end
end