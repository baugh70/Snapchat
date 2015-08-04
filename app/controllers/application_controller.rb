require "./config/enviornment"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweets = Snapchat.all
    erb :tweets
  end
end