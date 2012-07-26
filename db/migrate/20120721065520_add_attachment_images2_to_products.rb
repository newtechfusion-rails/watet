class AddAttachmentImages2ToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.has_attached_file :images2
    end
  end

  def self.down
    drop_attached_file :products, :images2
  end
end
