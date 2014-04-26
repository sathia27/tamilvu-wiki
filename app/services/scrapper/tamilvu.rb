class Tamilvu

  def initialize
    @page_start = 1
    @page_end = 1
  end

  def start
    (@page_start..@page_end).each do |page_no|
      puts page_no.to_s
      page = Nokogiri::HTML(open("http://www.tamilvu.org/slet/servlet/lexpg?pageno=#{page_no.to_s}"))
      page.css("tr[bgcolor='ivory']").each do |word|
        word.css('sup').remove
        begin
          w = Word.create(name: word.css('td')[0].text.gsub("\n", '').gsub("\r", ''))
          w.pronunciation = word.css('td')[1].children[0].text
          w.parts_of_speech = word.css('td')[1].children[2].text
          w.description = word.css('td')[1].children[3..-1].text
          w.save!
        rescue
        end
      end
    end
  end
end