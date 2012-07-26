class CreateAuthServices < ActiveRecord::Migration
	def change
		create_table :auth_services do |t|
			t.references :user
			t.string :provider
			t.string :uid
			t.string :uname
			t.string :uemail

			t.timestamps
		end
		add_index :auth_services, :user_id
	end
end
