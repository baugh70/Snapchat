require "./config/enviornment"
require "./app/models/model"

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
	
	get '/text' do
		require 'twilio-ruby'

account_sid = "ACe30ea6a63d05386cb6cac9a48615cd8e"
auth_token = "7ae7a566fd115e1e450986cb36ce315b"

@client = Twilio::REST::Client.new account_sid, auth_token
 
from = "+13477457924" # Your Twilio number
 
friends = {
	"+13472012586" => "User"
}
friends.each do |key, value|
  @client.account.messages.create(
    :from => from,
    :to => key,
		:body => "Hey #{value}, please log out... Thanks!"
  )
  puts "Sent message to #{value}"
end
	erb :text
	end
	
end