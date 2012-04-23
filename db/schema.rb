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

ActiveRecord::Schema.define(:version => 20120413212534) do

  create_table "hostprofiles", :force => true do |t|
    t.string   "tele"
    t.text     "serviceDesc"
    t.string   "aboutme"
    t.string   "price"
    t.string   "greenDesc"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "hostprofiles", ["user_id"], :name => "index_hostprofiles_on_user_id"

  create_table "reviews", :force => true do |t|
    t.string   "content"
    t.integer  "reviewer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "reviewee_id"
  end

  add_index "reviews", ["created_at"], :name => "index_reviews_on_reviewee_id_and_created_at"
  add_index "reviews", ["reviewer_id", "created_at"], :name => "index_reviews_on_reviewer_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "firstname"
    t.boolean  "is_host",         :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
