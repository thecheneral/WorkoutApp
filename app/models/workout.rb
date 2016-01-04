require 'nokogiri'
require 'open-uri'


class Workout < ActiveRecord::Base
	belongs_to :user
	belongs_to :gym

	
	def self.search(query)
	    self.where("workout_datetime LIKE :query OR description LIKE :query OR lift_type LIKE :query", query: "%#{query}%")
	end


	# attr_accessor :url,:date,:wod_from_site,:wod_date,:workout,:workout_feed
	
	# # def initialize
	# # 	@url = "http://www.oldcitycrossfit.com/wod/"
	# # 	#@time = Time.new
	# # 	@time = Date.parse('12-03-2015')
		
	# # end

	def self.get_gym_feed (url,workout_date)
		@date = "#{workout_date.month}#{workout_date.day}#{workout_date.year.to_s.split(//).last(2).join}"
		@wod_from_site = Nokogiri::HTML(open("#{@url}#{@date}/"))
		#would need to pass the date for the specific feed and would need to pass the specific date
		@workout = @wod_from_site.css('div.entry-content')[0].css('p').map{|p| p.children.first.text}
		@workout.drop(1)

		@workout.each do |line|
			puts "#{line}"
		end
	end
end

	# def get_wod_date
	# 	#to get the title of the entry (assuming that the date is different than the title) still need to pass the different gym site
	# 	@wod_date = @wod_from_site.xpath('//h1').children.last.text
	# end

	# def self.show_wod
	# 	puts "The workout for #{@wod_date} is:"
		
	# end


