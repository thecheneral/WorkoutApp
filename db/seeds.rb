# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Workout.delete_all
Gym.delete_all

user1 = User.all.first

gym1 = Gym.create(
	:name => "Old City Crossfit",
	:workout_url => "http://www.oldcitycrossfit.com/wod/",
	:default => true)


Workout.create( 
	:workout_datetime => DateTime.new(2016,1,1,12),
	:description => "10 Min EMOM: (Odd mins) 6 Strict Press @ 60%, (even mins) 6 Strict pullups
	 
	10 Min EMOM:
	5 Front Squats (115/75)
	5 Burpees
	– 2 min rest –
	10 min EMOM
	5 Squat Clean and Jerks (115/75)
	(Pause between movements – not a thruster)",
	:result => "2 10 Minute EMOMs",
	:lift_type => "Strict Press",
	:lift_weight => 81,
	:lift_rep_scheme => "10 Min EMOM: Odds 6 Strict Press @ 60%",
	:user_id => user1,
	:gym_id => gym1
)

puts "Workouts added, gym added."