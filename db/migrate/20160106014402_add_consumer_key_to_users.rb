class AddConsumerKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :consumer_key, :string
  end
end
