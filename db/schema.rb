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

ActiveRecord::Schema.define(version: 20160414002558) do

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.integer  "question_id"
    t.string   "user"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["question_id"], name: "index_comments_on_question_id"

  create_table "homeworks", force: :cascade do |t|
    t.string   "description"
    t.string   "attachment"
    t.string   "stg"
    t.integer  "students_tutor_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
  end

  add_index "homeworks", ["students_tutor_id"], name: "index_homeworks_on_students_tutor_id"

  create_table "meetings", force: :cascade do |t|
    t.integer  "students_tutor_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "start"
  end

  add_index "meetings", ["students_tutor_id"], name: "index_meetings_on_students_tutor_id"

  create_table "questions", force: :cascade do |t|
    t.string   "text"
    t.integer  "students_tutor_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "questions", ["students_tutor_id"], name: "index_questions_on_students_tutor_id"

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "password_hash"
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students_tutors", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "tutor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students_tutors", ["student_id"], name: "index_students_tutors_on_student_id"
  add_index "students_tutors", ["tutor_id"], name: "index_students_tutors_on_tutor_id"

  create_table "tutors", force: :cascade do |t|
    t.string   "name"
    t.string   "password_hash"
    t.string   "email"
    t.string   "field"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
