# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Delete current data from tables
User.delete_all
Workout.delete_all
Gym.delete_all
Membership.delete_all

#Create users
user1 = User.find_or_initialize_by(:email => "test@test.com",:first_name =>"test",:last_name=>"test")
user1.update_attributes(:password=>"password") if user1.new_record?

user2 = User.find_or_initialize_by(:email => "sample@sample.com",:first_name =>"sample",:last_name=>"sample")
user2.update_attributes(:password=>"password") if user2.new_record?

#Create gyms
gym1 = Gym.find_or_create_by(
	:name => "Old City Crossfit",
	:workout_url => "http://www.oldcitycrossfit.com/wod/")

gym2 = Gym.find_or_create_by(
	:name => "Random Gym",
	:workout_url => "http://www.random.com/")
# Gym.create(
# 	:name => "Sample Crossfit",
# 	:workout_url => "http://www.sample.com/wod/",
# 	:default => false)

#Seed join table
Membership.create(user: user1, gym: gym1, default: true)
Membership.create(user: user1, gym: gym2, default: false)
Membership.create(user: user2, gym: gym1, default: false)
Membership.create(user: user2, gym: gym2, default: true)

#Create workouts for User1 and User2
user1.workouts.create( 
	:workout_datetime => DateTime.new(2016,1,1,12),
	:description => "10 Min EMOM: (Odd mins) 6 Strict Press @ 60%, (even mins) 6 Strict pullups \n
	10 Min EMOM:\n
	5 Front Squats (115/75)\n
	5 Burpees\n
	– 2 min rest –\n
	10 min EMOM\n
	5 Squat Clean and Jerks (115/75)\n
	(Pause between movements – not a thruster)",
	:result => "2 10 Minute EMOMs",
	:lift_type => "Strict Press",
	:lift_weight => 81,
	:lift_rep_scheme => "10 Min EMOM: Odds 6 Strict Press @ 60%",
	:gym => gym1
)

user1.workouts.create( 
	:workout_datetime => DateTime.new(2015,12,5,06),
	:description => "Back Squat – 10 min EMOM – 2 reps at 75%\n
4 rounds:\n
10 x Hang Power Snatch (95/65)\n
10 x Push Press (95/65)\n
10 x Box Jump Overs (24/20)",
	:result => "12:04",
	:lift_type => "Back Squat",
	:lift_weight => 215,
	:lift_rep_scheme => "10 Min EMOM 2 reps @ 75%",
	:gym => gym1
)

user1.workouts.create( 
	:workout_datetime => DateTime.new(2015,12,3,06),
	:description => "Deadlift\n
3 sets of 5-6 reps @75% + heavy KBS\n
WOD\n
50 KB Swings(53/35)\n
800m Run\n
50 KB Swings\n",
	:result => "15:38",
	:lift_type => "Deadlift",
	:lift_weight => 275,
	:lift_rep_scheme => "3 sets of 5-6 reps @75% + heavy KBS",
	:gym => gym1
)


user2.workouts.create( 
	:workout_datetime => DateTime.new(2015,12,3,06),
	:description => "Deadlift\n
					3 sets of 5-6 reps @75% + heavy KBS\n
					WOD\n
					50 KB Swings(53/35)\n
					800m Run\n
					50 KB Swings\n",
	:result => "15:38",
	:lift_type => "Deadlift",
	:lift_weight => 275,
	:lift_rep_scheme => "3 sets of 5-6 reps @75% + heavy KBS",
	:gym => gym2
)

puts "User1 create password is password, 3 Workouts added, gyms added."
puts "User2 created password is password, 1 workout added, gym added for user2."