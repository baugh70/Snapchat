class Snapchat
	attr_reader :to_user, :caption, :timer, :time, :format, :link
	attr_accessor :read

	SNAPS = []

	def initialize(to_user, caption, timer, time, format, link)
# 		@user = user
		@to_user = to_user
		@caption = caption
		@timer = timer
		@time = time
		@link = link
		@read = false

		SNAPS << self

		if(format == "png" || format == "jpg" ||format == "jpeg")
			format = "pic"
		elsif (format == "mov" || format == "avi")
			format = "video"
		end
	end

	def self.all
		SNAPS
	end


end