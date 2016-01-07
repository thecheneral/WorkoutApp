class AddConsumerSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :consumer_secret, :string
  end
end
