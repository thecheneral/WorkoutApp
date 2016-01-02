class AddGymIdToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :gym_id, :integer
  end
end
