class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :fbid
      t.text :provider
      t.text :uid
      
      

      t.timestamps
    end
  end
end
