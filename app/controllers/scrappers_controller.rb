class ScrappersController < ApplicationController

  def index
  	require 'open-uri'
  	if params[:url]
	    url = open(params[:url])
	  else
	    url = open('https://newyork.craigslist.org/')
	  end
    # Sometime url redirected to other domain
    redirected_url = url.base_uri.to_s
    doc = Nokogiri::HTML(open(redirected_url))
    # @entries = doc.css('ul.menu.collapsible li.s a').each_with_index.map { |link,index| {:link=> link['href'], title: link.text, id: index+1 } }
    @entries = doc.css('a').each_with_index.map { |link,index| {:link=> link['href'], title: link.text, id: index+1 } }
  end

  def scrap_single_url
  	begin
	  	require 'open-uri'
	    url = open("https:" + params[:url])
	    #url = open("https://www.craigslist.org/about/privacy.policy")
	    # handle redirect, sometime url redirected to other domain
	    redirected_url = url.base_uri.to_s
	    doc = Nokogiri::HTML(open(redirected_url))
	    html_string   = doc.css('body').to_s
	    email_address = html_string.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)[0] rescue "No email found"
	    email_address = "No email found" if email_address.blank?    
    rescue
    	 email_address = "No email found"
    end

    respond_to do |format|
      format.json { render :json => { "email": email_address } }
    end
  end

end
