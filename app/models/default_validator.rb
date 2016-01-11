class DefaultValidator < ActiveModel::Validator
  def validate(record)
    byebug
    # a validator to check if there are any other gyms for the current user marked as default = true
    # if there is, the app will display an error
    if record.default == true
      memberships = Membership.find(userid: record.user_id)
      if memberships.any?
        memberships_default = memberships.map {|membership| membership.default}
        memberships_default = memberships_default.include?(true)
        if memberships_default
          record.errors[:base] << "You can only select one default gym."
        end
      end
    end
  end
end