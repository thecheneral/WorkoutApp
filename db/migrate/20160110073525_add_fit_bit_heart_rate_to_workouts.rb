class AddFitBitHeartRateToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :fitbit_heart_rate, :text
    add_column :workouts, :fitbit_steps, :text

  end
end
