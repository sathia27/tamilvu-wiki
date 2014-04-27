class HomeController < ApplicationController
  def index
    @word_count = Word.count
    @wiki_tamilvu = Word.existing_in_wiki.count
    @words_uploaded = Word.uploaded_to_wiki.count
    @scrapping_task = DelayedJob.where("handler LIKE ?", "%Scrapper::Tamilvu%").count > 0
    @uploading_task = DelayedJob.where("handler LIKE ?", "%upload_to_wiki%").count > 0
  end

  def upload_to_wiki
    return redirect_to root_path if DelayedJob.where("handler LIKE ?", "%upload_to_wiki%").count > 0
    Word.delay.upload_to_wiki
    redirect_to root_path
  end

  def scrap_from_tamilvu
    return redirect_to root_path if DelayedJob.where("handler LIKE ?", "%Scrapper::Tamilvu%").count > 0
    scrapping = Scrapper::Tamilvu.new
    scrapping.delay.start
    redirect_to root_path
  end

  def words
    model = params[:type] ? Word.send(params[:type]) : Word
    @total_words = model.count
    @words = model.page(params[:page]).per(50)
  end

  def word_counts
    render :json => {:word_count => Word.count, :existing_in_wiki => Word.existing_in_wiki.count, :uploaded_to_wiki => Word.uploaded_to_wiki.count }.to_json
  end
  
  def kill
    job = DelayedJob.where("handler LIKE ?", "%#{params[:type]}%").last
    if job
      if(job.locked_by)
        pid = job.locked_by.scan(/pid:([0-9]+)/).last.last
        begin
          #Process.kill("KILL", pid.to_i)
        rescue => e
          puts "No process #{pid}: #{e.to_s}"
        end
      end
      job.destroy
    end
    redirect_to root_path
  end
end
