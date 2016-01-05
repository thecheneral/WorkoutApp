# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Workout.delete_all
Gym.delete_all


user = User.find_or_initialize_by(:email => "test1@test.com",:first_name =>"test",:last_name=>"test")
user.update_attributes(:password=>"password") if user.new_record?

gym1 = user.gyms.find_or_create_by(
	:name => "Old City Crossfit",
	:workout_url => "http://www.oldcitycrossfit.com/wod/",
	:default => true)

Gym.create(
	:name => "Sample Crossfit",
	:workout_url => "http://www.sample.com/wod/",
	:default => false)

Workout.create( 
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
	:user => user1,
	:gym => gym1
)

Workout.create( 
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
	:user => user1,
	:gym => gym1
)

Workout.create( 
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
	:user => user1,
	:gym => gym1
)

puts "Workouts added, gym added."