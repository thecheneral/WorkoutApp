class RestrictMembershipNullFalse < ActiveRecord::Migration
  def change
    change_column_null :memberships, :user_id, false
    change_column_null :memberships, :gym_id, false
    change_column_null :memberships, :default, false
  end
end
