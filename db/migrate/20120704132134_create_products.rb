class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :descripton
      t.float :lat
      t.float :lng
      t.integer :user_id
      t.date :wish_date
      t.integer :order_id
      
      t.timestamps
    end
  end
end
