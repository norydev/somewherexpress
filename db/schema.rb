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

ActiveRecord::Schema.define(version: 20180310083158) do

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
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "picture"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_badges_on_user_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "locality"
    t.string   "country_short"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "picture"
  end

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "finished",                    default: false, null: false
    t.boolean  "published",                   default: false, null: false
    t.datetime "start_registration"
    t.datetime "end_registration"
    t.integer  "author_id"
    t.text     "description"
    t.string   "video"
    t.integer  "start_city_id"
    t.integer  "end_city_id"
    t.integer  "default_registration_status", default: 0,     null: false
    t.index ["start_city_id", "end_city_id"], name: "index_competitions_on_start_city_id_and_end_city_id", using: :btree
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
    t.index ["user_id"], name: "index_notification_settings_on_user_id", using: :btree
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
    t.index ["race_type", "race_id"], name: "index_ranks_on_race_type_and_race_id", using: :btree
    t.index ["user_id"], name: "index_ranks_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.integer  "competition_id",             null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "status",         default: 0, null: false
    t.index ["competition_id"], name: "index_subscriptions_on_competition_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "competition_id"
    t.datetime "start_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "start_city_id"
    t.integer  "end_city_id"
    t.index ["competition_id"], name: "index_tracks_on_competition_id", using: :btree
    t.index ["start_city_id", "end_city_id"], name: "index_tracks_on_start_city_id_and_end_city_id", using: :btree
  end

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
    t.string   "phone_number"
    t.boolean  "whatsapp",               default: false, null: false
    t.boolean  "telegram",               default: false, null: false
    t.boolean  "signal",                 default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "badges", "users"
  add_foreign_key "competitions", "cities", column: "end_city_id"
  add_foreign_key "competitions", "cities", column: "start_city_id"
  add_foreign_key "competitions", "users", column: "author_id"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "ranks", "users"
  add_foreign_key "subscriptions", "competitions"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tracks", "cities", column: "end_city_id"
  add_foreign_key "tracks", "cities", column: "start_city_id"
  add_foreign_key "tracks", "competitions"
end
