class AddAttachmentImages3ToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.has_attached_file :images3
    end
  end

  def self.down
    drop_attached_file :products, :images3
  end
end
