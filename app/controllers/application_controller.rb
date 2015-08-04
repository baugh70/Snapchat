require "./config/enviornment"
require "./app/models/snapchat"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @snaps = Snapchat.all
		erb :index
  end
	
	get '/new' do
		erb :snapchat
	end
	
	post '/new' do
		@snap = Snapchat.new(params[:to], params[:cap], params[:time], Time.now, "png", params[:url])
		@snaps = Snapchat.all
		erb :index
	end
	
end