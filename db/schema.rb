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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160725050437) do

  create_table "accounts", force: :cascade do |t|
    t.string   "username",             limit: 15,  null: false
    t.string   "email_address",        limit: 100, null: false
    t.string   "first_name",           limit: 25
    t.string   "last_name",            limit: 25
    t.string   "mobile_number",        limit: 10
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "password_digest",      limit: 255, null: false
    t.string   "password_reset_token", limit: 255
  end

  add_index "accounts", ["email_address"], name: "index_accounts_on_email_address", using: :btree
  add_index "accounts", ["username"], name: "index_accounts_on_username", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",         limit: 4
    t.integer  "account_id",      limit: 4
    t.text     "comment_message", limit: 65535, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "comments", ["account_id"], name: "index_comments_on_account_id", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "account_id",   limit: 4
    t.string   "post_title",   limit: 200,   null: false
    t.text     "post_message", limit: 65535, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "posts", ["account_id"], name: "index_posts_on_account_id", using: :btree

end
