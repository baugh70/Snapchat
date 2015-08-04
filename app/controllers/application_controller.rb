require "./config/enviornment"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    @tweet1 = Tweet.new("dududu", "I did it!")
    @tweet2 = Tweet.new("tswift", "#Feein22")
    @tweets = Tweet.all
    erb :tweets
  end
end