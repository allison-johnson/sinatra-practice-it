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

ActiveRecord::Schema.define(version: 2020_02_11_221211) do

  create_table "question_topics", force: :cascade do |t|
    t.integer "question_id"
    t.integer "topic_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "difficulty"
    t.text "prompt"
    t.integer "owner_id"
  end

  create_table "student_questions", force: :cascade do |t|
    t.integer "student_id"
    t.integer "question_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.integer "grade"
    t.integer "teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "username"
    t.boolean "is_admin"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name"
    t.string "first_name"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
  end

end
