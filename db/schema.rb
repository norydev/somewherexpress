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

ActiveRecord::Schema.define(version: 20151106203651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "start_location"
    t.string   "end_location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "result"
    t.integer  "points",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "race_id"
    t.string   "race_type"
  end

  add_index "ranks", ["race_type", "race_id"], name: "index_ranks_on_race_type_and_race_id", using: :btree
  add_index "ranks", ["user_id"], name: "index_ranks_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "subscriptions", ["competition_id"], name: "index_subscriptions_on_competition_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "competition_id"
    t.datetime "start_time"
    t.string   "start_location"
    t.string   "end_location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tracks", ["competition_id"], name: "index_tracks_on_competition_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "picture"
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "se_committee",           default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "ranks", "users"
  add_foreign_key "subscriptions", "competitions"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tracks", "competitions"
end
