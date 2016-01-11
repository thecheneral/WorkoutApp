class RemoveDefaultFromGyms < ActiveRecord::Migration
  def change
    remove_column :gyms, :default, :boolean
  end
end
