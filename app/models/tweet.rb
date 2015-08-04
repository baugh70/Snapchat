class Tweet
  attr_reader :username
  attr_accessor :content
  
  ALL_TWEETS = []
  
  def initialize(username, content)
    @username = username
    @content = content
    
    ALL_TWEETS << self
  end
  
  def self.all
    ALL_TWEETS
  end
end

tweet1 = Tweet.new("aojsdsdfsdf", "kewl")