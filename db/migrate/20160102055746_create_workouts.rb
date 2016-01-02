class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.datetime :workout_datetime
      t.text :description
      t.text :result
      t.string :lift_type
      t.integer :lift_weight
      t.string :lift_rep_scheme
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
