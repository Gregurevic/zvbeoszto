# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_15_214511) do

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "neptun"
  end

  create_table "examiners", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "instructor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_examiners_on_course_id"
    t.index ["instructor_id"], name: "index_examiners_on_instructor_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "can_be_president"
    t.boolean "can_be_secretary"
    t.boolean "can_be_member"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "neptun"
    t.string "email"
    t.integer "instructor_id", null: false
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_students_on_course_id"
    t.index ["instructor_id"], name: "index_students_on_instructor_id"
  end

  add_foreign_key "examiners", "courses"
  add_foreign_key "examiners", "instructors"
  add_foreign_key "students", "courses"
  add_foreign_key "students", "instructors"
end
