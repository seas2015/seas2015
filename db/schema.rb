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

ActiveRecord::Schema.define(version: 20160331230831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "equipment", force: :cascade do |t|
    t.string   "name"
    t.string   "equip_id"
    t.date     "buy_date"
    t.string   "brand"
    t.string   "note"
    t.date     "exp"
    t.string   "status"
    t.string   "serial"
    t.float    "price"
    t.string   "pic_id"
    t.string   "ownby"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "process"
    t.string   "campus"
    t.string   "location"
    t.string   "qr_id"
  end

  create_table "headshot_photos", force: :cascade do |t|
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "capturable_id"
    t.string   "capturable_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", force: :cascade do |t|
    t.string   "action"
    t.string   "action_id"
    t.string   "user_id"
    t.string   "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "equip_id"
    t.string   "detail"
    t.string   "keyword"
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.string   "note"
    t.string   "user_name"
    t.string   "user_id"
    t.string   "equip_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "equip_type"
    t.string   "checked_status"
    t.string   "staff_note"
    t.string   "pic_id"
    t.string   "action_needed"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "user_type"
    t.string   "user_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
