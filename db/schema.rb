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

ActiveRecord::Schema.define(version: 20140426125621) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "pos", force: true do |t|
    t.string   "name"
    t.string   "tamil_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pos", ["name"], name: "index_pos_on_name", using: :btree

  create_table "word_details", force: true do |t|
    t.integer "word_id"
    t.integer "pos_id"
    t.string  "parts_of_speech"
    t.string  "pronunciation"
    t.text    "description"
  end

  add_index "word_details", ["word_id", "pos_id"], name: "index_word_details_on_word_id_and_pos_id", unique: true, using: :btree

  create_table "words", force: true do |t|
    t.string   "name"
    t.string   "language",         default: "tamil"
    t.boolean  "existing_in_wiki", default: false
    t.boolean  "uploaded_to_wiki", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["existing_in_wiki"], name: "index_words_on_existing_in_wiki", using: :btree
  add_index "words", ["name"], name: "index_words_on_name", using: :btree
  add_index "words", ["uploaded_to_wiki"], name: "index_words_on_uploaded_to_wiki", using: :btree

end
