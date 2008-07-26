# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080719141551) do

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "status_codes", :force => true do |t|
    t.integer "status_type_id"
    t.string  "code"
    t.string  "description"
  end

  create_table "status_types", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "forenames",                 :limit => 100
    t.string   "surname",                   :limit => 100
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "feed_guid"
    t.datetime "watches_updated_at"
    t.string   "twitter_username",          :limit => 15
    t.string   "twitter_password",          :limit => 30
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "watches", :force => true do |t|
    t.integer  "user_id",                                      :null => false
    t.string   "name",       :limit => 50,  :default => "",    :null => false
    t.string   "address",    :limit => 500, :default => "",    :null => false
    t.string   "expected",                  :default => "",    :null => false
    t.string   "actual"
    t.boolean  "email",                     :default => false, :null => false
    t.boolean  "sms",                       :default => false, :null => false
    t.boolean  "alert_sent",                :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watches", ["name", "address"], :name => "index_watches_on_name_and_address"

end
