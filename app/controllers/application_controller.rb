require "./config/enviornment"
require "./app/models/snap"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
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
		
# 		@user = User.find_by(:to => params[:to])
		
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
			# 			need to add from user here and in erb when u log in
			@snap = Snap.new(:to => params[:to] , :caption => params[:cap], :timer => params[:time], :time => "#{time.hour}:#{time.min}",:format => "png", :link => params[:url], :read => "false")
      @snap.save
      @snaps = Snap.all
      redirect '/snaps'
		end
		
	end
	
	get '/snaps' do
		@snaps = Snap.all
		erb :snaps
	end
	
end