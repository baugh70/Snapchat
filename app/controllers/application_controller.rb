require "./config/enviornment"
require "./app/models/snapchat"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweets = Snapchat.all
		erb :index
  end
	
	get '/new' do
		erb :snapchat
	end
	
	post '/new' do
		erb :index
	end
	
end