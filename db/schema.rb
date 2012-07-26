# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120723113403) do

  create_table "auth_services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_services", ["user_id"], :name => "index_auth_services_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "descripton"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.date     "wish_date"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "images_file_name"
    t.string   "images_content_type"
    t.integer  "images_file_size"
    t.datetime "images_updated_at"
    t.string   "images1_file_name"
    t.string   "images1_content_type"
    t.integer  "images1_file_size"
    t.datetime "images1_updated_at"
    t.string   "images2_file_name"
    t.string   "images2_content_type"
    t.integer  "images2_file_size"
    t.datetime "images2_updated_at"
    t.string   "images3_file_name"
    t.string   "images3_content_type"
    t.integer  "images3_file_size"
    t.datetime "images3_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "fbid"
    t.text     "provider"
    t.text     "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",     :default => "en"
    t.boolean  "terms",      :default => false
  end

end
