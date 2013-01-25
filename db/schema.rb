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

ActiveRecord::Schema.define(:version => 20130104084231) do

  create_table "archives", :force => true do |t|
    t.integer  "bucket_id"
    t.integer  "recording_id"
    t.string   "file_name"
    t.string   "file_format"
    t.datetime "file_date"
    t.integer  "status"
    t.datetime "last_modified"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "conferences", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "active"
  end

  add_index "conferences", ["state_id"], :name => "index_conferences_on_state_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "logs", :force => true do |t|
    t.integer  "server_id"
    t.integer  "log_type"
    t.text     "log_message"
    t.datetime "log_time"
    t.integer  "status"
    t.datetime "last_modified"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "city"
    t.string   "zip_code"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "status",          :default => false
    t.decimal  "total_price"
    t.boolean  "individual_game", :default => false
    t.integer  "school_id"
    t.integer  "team_id"
    t.decimal  "tax"
    t.string   "subscription_id"
    t.boolean  "cancel",          :default => false
    t.string   "transaction_id"
  end

  create_table "recordings", :force => true do |t|
    t.integer  "schedule_id"
    t.string   "stream_name"
    t.string   "recording_name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "status"
    t.datetime "last_modified"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "requests", :force => true do |t|
    t.string   "state"
    t.string   "team"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "s3_buckets", :force => true do |t|
    t.string   "s3_url"
    t.string   "s3_zone"
    t.string   "s3_permission"
    t.integer  "status"
    t.datetime "last_modified"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "subteam_id"
    t.integer  "opponent_id"
    t.integer  "sport_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.datetime "start_time"
    t.datetime "event_date"
    t.float    "score_home"
    t.float    "score_opponent"
    t.integer  "venue_id"
    t.datetime "end_time"
    t.string   "us_timezone",    :default => "Eastern Time (US & Canada)"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "conference_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "schools", ["conference_id"], :name => "index_schools_on_conference_id"

  create_table "servers", :force => true do |t|
    t.string   "server_uri"
    t.string   "server_zone"
    t.integer  "status"
    t.datetime "last_modified"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "imgage"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "active"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  create_table "stats", :force => true do |t|
    t.integer  "schedule_id"
    t.datetime "stat_time"
    t.integer  "stat_type"
    t.integer  "stat_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subteams", :force => true do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "teamsport_id"
  end

  create_table "team_managements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.integer  "school_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "slug"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "logo_image_file_name"
    t.string   "logo_image_content_type"
    t.integer  "logo_image_file_size"
    t.datetime "logo_image_updated_at"
    t.string   "mascot"
  end

  add_index "teams", ["school_id"], :name => "index_teams_on_school_id"
  add_index "teams", ["slug"], :name => "index_teams_on_slug"

  create_table "teamsports", :force => true do |t|
    t.integer  "sport_id"
    t.integer  "team_id"
    t.string   "name"
    t.string   "logo_image_file_name"
    t.string   "logo_image_content_type"
    t.integer  "logo_image_file_size"
    t.datetime "logo_image_updated_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "teamsports", ["sport_id"], :name => "index_teamsports_on_sport_id"
  add_index "teamsports", ["team_id"], :name => "index_teamsports_on_team_id"

  create_table "testings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "role"
    t.date     "purchase_at"
    t.integer  "team_id"
    t.boolean  "status",                 :default => true
    t.string   "user_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "venue"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "team_id"
  end

end
