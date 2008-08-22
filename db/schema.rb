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

ActiveRecord::Schema.define(:version => 20080709151448) do

  create_table "users", :force => true do |t|
    t.string   "legal_name",             :null => false
    t.string   "name_key",               :null => false
    t.string   "password",               :null => false
    t.datetime "created_at"
    t.string   "email",                  :null => false
    t.string   "email_key",              :null => false
    t.datetime "email_verified_at"
    t.datetime "last_action_at"
    t.string   "city"
    t.string   "region"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "address_verified_at"
    t.string   "phone"
    t.string   "voter_registration_id"
    t.date     "birthdate"
    t.string   "sex"
    t.string   "sexual_orientation"
    t.string   "religious_affiliations"
    t.string   "race"
    t.integer  "height_inches"
    t.integer  "weight_lbs"
    t.string   "marital_status"
  end

  add_index "users", ["last_action_at"], :name => "index_users_on_last_action_at"
  add_index "users", ["email_verified_at"], :name => "index_users_on_email_verified_at"
  add_index "users", ["email_key"], :name => "index_users_on_email_key"
  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["password"], :name => "index_users_on_password"
  add_index "users", ["legal_name"], :name => "index_users_on_legal_name"
  add_index "users", ["name_key"], :name => "index_users_on_name_key"

end
