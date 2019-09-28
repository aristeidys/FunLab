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

ActiveRecord::Schema.define(version: 2019_09_28_162657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password"
  end

  create_table "modules", force: :cascade do |t|
    t.string "name"
  end

  create_table "session_results", force: :cascade do |t|
    t.boolean "completed"
    t.decimal "totalScore"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.boolean "isActive"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password"
  end

  create_table "task_results", force: :cascade do |t|
    t.boolean "completed"
    t.boolean "succeeded"
    t.decimal "numberOfGoodHelp"
    t.decimal "numberOfBadHelp"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.decimal "difficulty"
  end

end
