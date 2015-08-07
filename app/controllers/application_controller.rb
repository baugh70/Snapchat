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
	
	post '/register' do
		username = params[:username]
		password = params[:password]
		email = params[:email]
		if (username == "")
			@error = "USERNAME"
			@link = "/register"
			erb :noPic
		elsif (password == "")
			@error = "PASSWORD"
			@link = "/register"
			erb :noPic
		elsif (email == "")
			@error = "EMAIL"
			@link = "/register"
			erb :noPic
		else
		user = User.new(:username => username, :password => password, :email => email, :friends => "")
		user.save
		puts User.all
		@snaps = Snap.all
		redirect '/snaps'
		end
	end
	
	get '/new' do
		erb :snapchat
	end
	
	post '/new' do
		
# 		@user = User.find_by(:to => params[:to])
		
    time  = Time.new
		
		if (params[:url] == "") || (params[:url][0..3].downcase != "http")
			@error = "URL"
			@link = "/new"
			erb :noPic
		elsif (params[:to] == "")
			@error = "RECIPIENT"
			@link = "/new"
			erb :noPic
		elsif (params[:time] == "none")  
			@error = "TIME LIMIT"
			@link = "/new"
			erb :noPic
		else
			# 			need to add from user here and in erb when u log in
      @user = User.find_by(:username => params[:to])
      @snap = Snap.new(:user_id => "@user.id ", :caption => params[:cap], :timer => params[:time], :time => "#{time.hour}:#{time.min}",:format => "png", :link => params[:url], :read => "false")
      @snap.save
      @snaps = Snap.all
      redirect '/snaps'
		end
		
	end
	
	get '/snaps' do
		@snaps = Snap.all
		erb :snaps
	end

	get '/register' do
		erb :register
	end

	get '/login' do
		puts "get login"
		erb :login
	end

	post '/login' do
		puts "login"
		username = params[:username]
		password = params[:password]
		if (username == "")
			@error = "USERNAME"
			@link = "/login"
			erb :noPic
		elsif (password == "")
			@error = "PASSWORD"
			@link = "/login"
			erb :noPic
		else
			if (username.include? "@")
			user_by_email = User.find_by(:email => username)

			puts "else in post login"
			if (password == user_by_email.password)
				redirect '/snaps'
			else
				@error = "PASSWORD"
				@link = "/login"
				erb :noPic
			end
			else
				user_by_name = User.find_by(:username => username)

			puts "else in post login"
			if (password == user_by_name.password)
				redirect '/snaps'
			else
				@error = "PASSWORD"
				@link = "/login"
				erb :noPic
			end
			end
			# user_by_name = User.find_by(:username => username)

			# puts "else in post login"
			# if (password == user_by_name.password) || (password == user_by_email.password)
			# 	redirect '/snaps'
			# else
			# 	@error = "PASSWORD"
			# 	@link = "/login"
			# 	erb :noPic
			# end

		end
	end
	
end