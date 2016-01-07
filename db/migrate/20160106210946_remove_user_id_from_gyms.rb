class RemoveUserIdFromGyms < ActiveRecord::Migration
  def change
    remove_column :gyms, :user_id, :integer
  end
end
