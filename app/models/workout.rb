class Workout < ActiveRecord::Base
	belongs_to :user
	belongs_to :gym

	validates_with WorkoutTimeValidator

	
	def self.search(query)
	   	self.where("workout_datetime LIKE :query OR description LIKE :query OR lift_type LIKE :query", query: "%#{query}%")
	    # self.where( "strftime('%M', workout_datetime) + 0 = ?" LIKE :query)
	end


	# attr_accessor :url,:date,:wod_from_site,:wod_date,:workout,:workout_feed
	
	# # def initialize
	# # 	@url = "http://www.oldcitycrossfit.com/wod/"
	# # 	#@time = Time.new
	# # 	@time = Date.parse('12-03-2015')
		
	# # end

#method to get the gym feed parsed...need error handling
	def get_gym_feed (url,selected_date)
		@url = url
		@date = selected_date
		@date = "#{@date.month}#{@date.day}#{@date.year.to_s.split(//).last(2).join}"
		begin
			@wod_from_site = Nokogiri::HTML(Net::HTTP.get(URI("#{@url}#{@date}/")))
			#would need to pass the date for the specific feed and would need to pass the specific date
			@workout = @wod_from_site.css('div.entry-content')[0].css('p').map{|p| p.children.first.text}
			# @workout.drop(1)
			# @workout.drop(2)
			@workout.reject! &:blank?
			return @workout.join("\n")
		 rescue => e
		 	return e
		 end
	end

	def refresh_fitbit_access_token
		expired_client = Fitbit::Client.new(
			  client_id: ENV['FITBIT_CLIENT_ID'],
			  client_secret: ENV['FITBIT_CLIENT_SECRET'],
			  access_token: user.access_token,
			  refresh_token: user.refresh_token,
			  expires_at: Time.at(user.expires_at)
			  )
		new_client = expired_client.refresh!
	end

	def get_fitbit_hr_data (selected_date, user)
		@date = selected_date

		if DateTime.now > Time.at(user.expires_at)
			@refresh = refresh_fitbit_access_token
			user.update(access_token: @refresh.token, refresh_token: @refresh.refresh_token, expires_at: @refresh.expires_at)
			
			client = Fitbit::Client.new(
			  client_id: ENV['FITBIT_CLIENT_ID'],
			  client_secret: ENV['FITBIT_CLIENT_SECRET'],
			  access_token: user.access_token,
			  refresh_token: user.refresh_token,
			  expires_at: Time.at(user.expires_at)
			  )
			client.heart_rate_intraday_time_series(user_id: '-', date: @date.strftime('%Y-%m-%d'), start_time: @date.strftime('%H:%M'),end_time:(@date + 1.hour).strftime('%H:%M'), detail_level: '1min')		
		
		else	
			client = Fitbit::Client.new(
			  client_id: ENV['FITBIT_CLIENT_ID'],
			  client_secret: ENV['FITBIT_CLIENT_SECRET'],
			  access_token: user.access_token,
			  refresh_token: user.refresh_token,
			  expires_at: Time.at(user.expires_at)
			  )
			client.heart_rate_intraday_time_series(user_id: '-', date: @date.strftime('%Y-%m-%d'), start_time: @date.strftime('%H:%M'),end_time:(@date + 1.hour).strftime('%H:%M'), detail_level: '1min')		
		end
	end

	def parse_fitbit_hr
		# @hr_minute_date.map{|hr| hr["value"]}
	end


end


	# def get_wod_date
	# 	#to get the title of the entry (assuming that the date is different than the title) still need to pass the different gym site
	# 	@wod_date = @wod_from_site.xpath('//h1').children.last.text
	# end

	# def self.show_wod
	# 	puts "The workout for #{@wod_date} is:"
		
	# end


