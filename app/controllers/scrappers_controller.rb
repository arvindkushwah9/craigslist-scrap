class ScrappersController < ApplicationController

  def index
    begin
    	require 'open-uri'
    	if params[:domain]
  	    url = open(params[:domain])
  	  else
  	    url = open('https://newyork.craigslist.org')
  	  end
      # Sometime url redirected to other domain
      redirected_url = url.base_uri.to_s
      doc = Nokogiri::HTML(open(redirected_url))
     
      @entries = doc.css('a').each_with_index.map { |link,index| {:link=> link['href'], title: link.text, id: index+1} if ["#", "/"].exclude? link['href']}.compact.uniq
       urls =  @entries.map { |link| link[:link]}
      SaveUrlsWorker.perform_async(redirected_url, urls)
    rescue
    end
  end

  def scrap_single_url
  	 begin
	  	require 'open-uri'
      if ["#", "/"].exclude? params[:url]
        if params[:url].include? "http"
          url = params[:url]
        elsif params[:url].include? "//"
          url = "https:" + params[:url]
        elsif params[:url].exclude? "craigslist."
          url = params[:domain] + params[:url]
        else
          url = params[:url]
        end
  	    url = open(url)

  	    # handle redirect, sometime url redirected to other domain
  	    redirected_url = url.base_uri.to_s
  	    doc = Nokogiri::HTML(open(redirected_url))       
        urls = doc.css('a').map { |link| link['href']}

        SaveUrlsWorker.perform_async(redirected_url, urls)

  	    html_string   = doc.css('body').to_s
  	    email_address = html_string.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0] rescue "No email found"
  	    email_address = "No email found" if email_address.blank? 
       
      end
    rescue
         email_address = "No email found"
    end
    respond_to do |format|
      format.json { render :json => { "email": email_address } }
    end
  end

  def results
    if params[:step] == "2"
      urls = Url.where("url like ? ", "%.html%")
    else
      urls = Url.all
    end
    @entries = urls.uniq { |i| i.url }.each_with_index.map { |link,index| {:link=> link.url, id: index+1 } if ["/","#"].exclude? link.url }.compact.uniq
  end

end
