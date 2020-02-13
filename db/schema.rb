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

ActiveRecord::Schema.define(version: 20200211221211) do

  create_table "question_topics", force: :cascade do |t|
    t.integer "question_id"
    t.integer "topic_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string  "difficulty"
    t.text    "prompt"
    t.integer "owner_id"
  end

  create_table "student_questions", force: :cascade do |t|
    t.integer "student_id"
    t.integer "question_id"
  end

  create_table "students", force: :cascade do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.integer "grade"
    t.integer "teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "username"
    t.boolean  "is_admin"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_name"
    t.string   "first_name"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
  end

end
