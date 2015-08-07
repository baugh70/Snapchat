require "./config/enviornment"
require "./app/models/snap"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, 'admin123'
  end
  
  get '/' do
		erb :index
  end
	
	get '/snaps' do
		if session[:user_id] != nil
			@username = User.find_by(session[:user_id]).username.capitalize
			@snaps = Snap.all
			erb :snaps
		else
			redirect '/'
		end
	end
	
	get '/new' do
		if session[:user_id] != nil
			erb :snapchat
		else
			redirect '/'
		end
	end
	
	post '/new' do
		if session[:user_id] != nil
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
      	@user = User.find_by(:username => params[:to])
      	@snap = Snap.new(:user_id => @id, :caption => params[:cap], :timer => params[:time], :time => "#{time.hour}:#{time.min}",:format => "png", :link => params[:url], :read => "false")
      	@snap.save
      	@snaps = Snap.all
      	redirect '/snaps'
			end
		else
			redirect '/'
		end	
	end
	
	get '/register' do
		erb :register
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
			user = User.create(:username => username, :password => password, :email => email, :friends => "")
			@snaps = Snap.all
			redirect '/snaps'
		end
	end
	
	get '/login' do
		erb :login
	end
	
	post '/login' do
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
				user = User.find_by(:email => username)
			else
				user = User.find_by(:username => username)
			end
			
			if (password == user.password)
				if user
					@username = user.username
					session[:user_id] = user.id
					redirect '/snaps'
				else
					redirect '/register'
				end
			else
				@error = "PASSWORD"
				@link = "/login"
				erb :noPic
			end
		end
	end

	get '/logout' do
		session[:user_id] = nil
		redirect '/'
	end	
end