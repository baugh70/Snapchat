require "./config/enviornment"
require "./app/models/snap"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @snaps = Snap.all
# 		time = Time.new
# 		# 		this is just test code to test multiple tweets, we can delete it later
# 		snap1 = Snap.new("params[:to]", "test caption", 5, "Sent at #{time.hour}:#{time.min}", "png", "http://www.cats.org.uk/uploads/images/pages/photo_latest14.jpg")
# 		@snap2 = Snap.new("params[:to]", "test caption", 3, "Sent at #{time.hour}:#{time.min}", "png", "http://www.lauramcalister.com/wp-content/uploads/2015/07/534806-cat.jpg")
#     @snap1.save
		erb :index
  end
	
	get '/new' do
		erb :snapchat
	end
	
	post '/new' do
    time  = Time.new
		
		if (params[:url] == "") || (params[:url][0..3].downcase != "http")
			@error = "URL"
			erb :noPic
		elsif (params[:to] == "")
			@error = "RECIPIENT"
			erb :noPic
		elsif (params[:time] == "none")  
			@error = "TIME LIMIT"
			erb :noPic
		else
      @snap = Snap.new(:to => params[:to], :caption => params[:cap], :timer => params[:time], :time => "#{time.hour}:#{time.min}",:format => "png", :link => params[:url], :read => "false")
      @snap.save
      @snaps = Snap.all
      redirect '/'
		end
		
	end
	
end