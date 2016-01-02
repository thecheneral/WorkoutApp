class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :workout_url
      t.boolean :default

      t.timestamps null: false
    end
  end
end
