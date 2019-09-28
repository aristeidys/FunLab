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
    t.bigint "instructor_id"
    t.string "name"
    t.index ["instructor_id"], name: "index_modules_on_instructor_id"
  end

  create_table "session_results", force: :cascade do |t|
    t.bigint "session_id"
    t.bigint "student_id"
    t.boolean "completed"
    t.decimal "totalScore"
    t.index ["session_id"], name: "index_session_results_on_session_id"
    t.index ["student_id"], name: "index_session_results_on_student_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "module_id"
    t.string "name"
    t.boolean "isActive"
    t.index ["module_id"], name: "index_sessions_on_module_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password"
  end

  create_table "task_results", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "task_id"
    t.boolean "completed"
    t.boolean "succeeded"
    t.decimal "numberOfGoodHelp"
    t.decimal "numberOfBadHelp"
    t.index ["student_id"], name: "index_task_results_on_student_id"
    t.index ["task_id"], name: "index_task_results_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "session_id"
    t.string "name"
    t.decimal "difficulty"
    t.index ["session_id"], name: "index_tasks_on_session_id"
  end

end
