class DefaultValidator < ActiveModel::Validator
  def validate(record)
    
    # a validator to check if there are any other gyms for the current user marked as default = true
    # if there is, the app will display an error
    if record.default == true
      memberships = Membership.find_by(user_id: record.user_id, default: true)
      if memberships
        record.errors[:alert] << "You can only select one default gym."
      end
    end
  end
end