require 'Nokogiri'
require 'open-uri'	

class WorkoutScraper
	
	attr_reader :url,:date,:wod_from_site,:wod_date,:workout,:workout_feed
	
	def initialize (url,workout_date)
		@url = url
		@date = "#{workout_date.month}#{workout_date.day}#{workout_date.year.to_s.split(//).last(2).join}"
		#@time = Time.new
		# @time = Date.parse('12-03-2015')
	end

	def get_gym_feed
		@wod_from_site = Nokogiri::HTML(open("#{@url}#{@date}/"))
		#would need to pass the date for the specific feed and would need to pass the specific date
		@workout = @wod_from_site.css('div.entry-content')[0].css('p').map{|p| p.children.first.text}

	end

	def get_class_items
		@workout.drop(1)

		@workout.each do |line|
			puts "#{line}"
		end
	end
end