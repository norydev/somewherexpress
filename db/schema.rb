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

ActiveRecord::Schema.define(version: 20151123184852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "picture"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "badges", ["user_id"], name: "index_badges_on_user_id", using: :btree

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "start_location"
    t.string   "end_location"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.float    "start_location_lat"
    t.float    "start_location_lng"
    t.float    "end_location_lat"
    t.float    "end_location_lng"
    t.string   "start_location_street_number"
    t.string   "start_location_route"
    t.string   "start_location_locality"
    t.string   "start_location_administrative_area_level_2"
    t.string   "start_location_administrative_area_level_1"
    t.string   "start_location_administrative_area_level_1_short"
    t.string   "start_location_country"
    t.string   "start_location_country_short"
    t.string   "start_location_postal_code"
    t.string   "end_location_street_number"
    t.string   "end_location_route"
    t.string   "end_location_locality"
    t.string   "end_location_administrative_area_level_2"
    t.string   "end_location_administrative_area_level_1"
    t.string   "end_location_administrative_area_level_1_short"
    t.string   "end_location_country"
    t.string   "end_location_country_short"
    t.string   "end_location_postal_code"
    t.boolean  "finished",                                         default: false, null: false
    t.boolean  "published",                                        default: false, null: false
    t.datetime "start_registration"
    t.datetime "end_registration"
    t.integer  "author_id"
    t.text     "description"
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "result",     default: 0
    t.integer  "points",     default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "race_id"
    t.string   "race_type"
    t.boolean  "dsq",        default: false, null: false
  end

  add_index "ranks", ["race_type", "race_id"], name: "index_ranks_on_race_type_and_race_id", using: :btree
  add_index "ranks", ["user_id"], name: "index_ranks_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.integer  "competition_id",                     null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "status",         default: "applied", null: false
  end

  add_index "subscriptions", ["competition_id"], name: "index_subscriptions_on_competition_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "competition_id"
    t.datetime "start_time"
    t.string   "start_location"
    t.string   "end_location"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.float    "start_location_lat"
    t.float    "start_location_lng"
    t.float    "end_location_lat"
    t.float    "end_location_lng"
    t.string   "start_location_street_number"
    t.string   "start_location_route"
    t.string   "start_location_locality"
    t.string   "start_location_administrative_area_level_2"
    t.string   "start_location_administrative_area_level_1"
    t.string   "start_location_administrative_area_level_1_short"
    t.string   "start_location_country"
    t.string   "start_location_country_short"
    t.string   "start_location_postal_code"
    t.string   "end_location_street_number"
    t.string   "end_location_route"
    t.string   "end_location_locality"
    t.string   "end_location_administrative_area_level_2"
    t.string   "end_location_administrative_area_level_1"
    t.string   "end_location_administrative_area_level_1_short"
    t.string   "end_location_country"
    t.string   "end_location_country_short"
    t.string   "end_location_postal_code"
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
    t.boolean  "organizer",              default: false, null: false
    t.boolean  "girl",                   default: false, null: false
    t.datetime "deleted_at"
    t.string   "old_first_name"
    t.string   "old_last_name"
    t.string   "old_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "badges", "users"
  add_foreign_key "competitions", "users", column: "author_id"
  add_foreign_key "ranks", "users"
  add_foreign_key "subscriptions", "competitions"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tracks", "competitions"
end
