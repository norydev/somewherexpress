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

ActiveRecord::Schema.define(version: 20160409174037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "picture"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "badges", ["user_id"], name: "index_badges_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "street_number"
    t.string   "route"
    t.string   "locality"
    t.string   "administrative_area_level_2"
    t.string   "administrative_area_level_1"
    t.string   "administrative_area_level_1_short"
    t.string   "country"
    t.string   "country_short"
    t.string   "postal_code"
    t.float    "lat"
    t.float    "lng"
    t.integer  "localizable_id"
    t.string   "localizable_type"
    t.string   "order",                             default: "start", null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "cities", ["localizable_type", "localizable_id"], name: "index_cities_on_localizable_type_and_localizable_id", using: :btree

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "finished",                    default: false,     null: false
    t.boolean  "published",                   default: false,     null: false
    t.datetime "start_registration"
    t.datetime "end_registration"
    t.integer  "author_id"
    t.text     "description"
    t.string   "default_registration_status", default: "pending", null: false
    t.string   "video"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "as_user_new_competition",             default: true, null: false
    t.boolean  "as_user_competition_edited",          default: true, null: false
    t.boolean  "as_user_new_subscription",            default: true, null: false
    t.boolean  "as_user_subscription_status_changed", default: true, null: false
    t.boolean  "as_author_new_subscription",          default: true, null: false
    t.boolean  "as_author_cancelation",               default: true, null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "locale",                              default: "fr", null: false
  end

  add_index "notification_settings", ["user_id"], name: "index_notification_settings_on_user_id", using: :btree

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
    t.string   "status",         default: "pending", null: false
  end

  add_index "subscriptions", ["competition_id"], name: "index_subscriptions_on_competition_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.integer  "competition_id"
    t.datetime "start_time"
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
    t.boolean  "organizer",              default: false, null: false
    t.boolean  "girl",                   default: false, null: false
    t.datetime "deleted_at"
    t.string   "old_first_name"
    t.string   "old_last_name"
    t.string   "old_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "use_gravatar",           default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "badges", "users"
  add_foreign_key "competitions", "users", column: "author_id"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "ranks", "users"
  add_foreign_key "subscriptions", "competitions"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tracks", "competitions"
end
