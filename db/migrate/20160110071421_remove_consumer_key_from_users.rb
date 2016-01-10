class RemoveConsumerKeyFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :consumer_key, :string
    remove_column :users, :consumer_secret, :string
    add_column :users, :expires_at, :integer
  end
end
