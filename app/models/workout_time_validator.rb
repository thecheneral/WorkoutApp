class WorkoutTimeValidator < ActiveModel::Validator
  def validate(record)
    if Time.at(record.workout_datetime) > DateTime.now - 1.hour
      record.errors[:alert] << "This workout is not in the past. Please note logged time needs to be older than an hour."
    end
  end
end