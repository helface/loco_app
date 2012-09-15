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

ActiveRecord::Schema.define(:version => 20120915015215) do

  create_table "appointments", :force => true do |t|
    t.integer  "traveler_id"
    t.integer  "host_id"
    t.text     "message",     :limit => 400
    t.date     "date"
    t.string   "time"
    t.integer  "status"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "country_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forumposts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "responded_count", :default => 0
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "time"
    t.date     "date"
  end

  add_index "forumposts", ["city_id", "created_at"], :name => "index_forumposts_on_city_id_and_created_at"
  add_index "forumposts", ["user_id", "created_at"], :name => "index_forumposts_on_user_id_and_created_at"

  create_table "hostprofiles", :force => true do |t|
    t.string   "tele"
    t.text     "serviceDesc"
    t.string   "exchange_type"
    t.string   "greenDesc"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "recommend_count",   :default => 0
    t.integer  "unrecommend_count", :default => 0
    t.integer  "contacted_count",   :default => 0
    t.integer  "responded_count",   :default => 0
    t.integer  "service"
    t.string   "languages"
    t.integer  "price"
    t.string   "currency"
    t.float    "score",             :default => 0.0
    t.string   "intro"
    t.integer  "completed_count",   :default => 0
    t.string   "language_practice"
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "caption"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "thread_id"
    t.integer  "owner_id"
    t.boolean  "read",         :default => false
  end

  create_table "msgthreads", :force => true do |t|
    t.integer  "participant2_id"
    t.integer  "participant1_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "subject"
  end

  create_table "reviews", :force => true do |t|
    t.string   "content"
    t.integer  "reviewer_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "reviewee_id"
    t.boolean  "recommend"
    t.integer  "accuracy"
    t.integer  "enjoybility"
    t.integer  "easiness"
    t.integer  "friendliness"
    t.float    "score"
    t.boolean  "is_host_review"
    t.float    "guest_score"
  end

  add_index "reviews", ["created_at"], :name => "index_reviews_on_reviewee_id_and_created_at"
  add_index "reviews", ["reviewer_id", "created_at"], :name => "index_reviews_on_reviewer_id_and_created_at"

  create_table "services", :force => true do |t|
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",              :default => false
    t.string   "firstname"
    t.boolean  "is_host",            :default => false
    t.string   "confirmation_token"
    t.boolean  "confirmed",          :default => false
    t.integer  "profile_pic_id"
    t.integer  "completed_count",    :default => 0
    t.string   "self_intro",         :default => ""
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
