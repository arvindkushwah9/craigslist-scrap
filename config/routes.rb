Rails.application.routes.draw do
  root "home#index"
  get '/craigslist', :to => 'scrappers#index'
  post '/scrap_single_url', :to => 'scrappers#scrap_single_url'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
