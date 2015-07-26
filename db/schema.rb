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

ActiveRecord::Schema.define(version: 20150726003854) do

  create_table "favourites", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "student_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "favourites", ["organization_id"], name: "index_favourites_on_organization_id"
  add_index "favourites", ["student_id"], name: "index_favourites_on_student_id"

  create_table "opportunities", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "opportunities", ["organization_id"], name: "index_opportunities_on_organization_id"

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "password_digest"
    t.integer  "favourites_count", default: 0
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone_number"
    t.string   "profile_pic"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "about"
  end

end
