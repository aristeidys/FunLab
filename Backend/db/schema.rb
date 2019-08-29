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

ActiveRecord::Schema.define(version: 2019_08_16_214735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lab_session_id"
    t.index ["lab_session_id"], name: "index_activities_on_lab_session_id"
  end

  create_table "enrolments", force: :cascade do |t|
    t.bigint "lab_session_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_session_id"], name: "index_enrolments_on_lab_session_id"
    t.index ["student_id"], name: "index_enrolments_on_student_id"
  end

  create_table "lab_sessions", force: :cascade do |t|
    t.string "title"
    t.boolean "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "lab_sessions"
end
