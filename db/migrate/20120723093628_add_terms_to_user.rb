class AddTermsToUser < ActiveRecord::Migration
  def change
    add_column :users,  :terms ,:boolean, :default => "0"
  end
end
