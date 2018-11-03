class SaveUrlsWorker
  include Sidekiq::Worker

  def perform(domain, urls)
  	base_url = BaseUrl.find_or_create_by(url: domain, is_scrap: true)
    urls.each do |url|
	  	url = Url.find_or_initialize_by(url: url)
	  	url.base_url_id = base_url.id
	  	url.save
	end
  end
end
