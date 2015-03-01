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

ActiveRecord::Schema.define(version: 20150301024614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: :cascade do |t|
    t.date     "talk_date"
    t.integer  "number_of_slots"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lightning_talks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "day_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string  "email",                      null: false
    t.string  "auth_token",                 null: false
    t.string  "username",                   null: false
    t.boolean "admin",      default: false
  end

end
