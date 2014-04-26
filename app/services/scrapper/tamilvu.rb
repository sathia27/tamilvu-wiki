require 'open-uri'
class Scrapper::Tamilvu

  def initialize
    @page_start = 1
    @page_end = 5
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
          tag = word.css('td')[1]
          pos_name = tag.children[2].text.split(".")[0]
          pos = Pos.find_or_create_by(name: pos_name)
          title = word.css('td')[0].text.gsub("\n", '').gsub("\r", '')
          w = Word.find_or_create_by(name: title)
          w.tamil_vu_page_no = page_no
          w.save
          detail = WordDetail.new(word_id: w.id, pos_id: pos.id)
          detail.pronunciation = tag.children[0].text
          detail.description = tag.children[3..-1].text.gsub(/[0-9]+[\.|\s]/, "\n#")
          detail.save
        rescue => e
          puts e.inspect
        end
      end
    end
  end
end
