class AddAttachmentImages1ToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.has_attached_file :images1
    end
  end

  def self.down
    drop_attached_file :products, :images1
  end
end
