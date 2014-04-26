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

ActiveRecord::Schema.define(version: 20140426071352) do

  create_table "words", force: true do |t|
    t.string   "word"
    t.string   "pronunciation"
    t.string   "parts_of_speech"
    t.string   "language",                      default: "tamil"
    t.string   "description",      limit: 1000
    t.boolean  "existing_in_wiki"
    t.boolean  "uploaded_to_wiki"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["existing_in_wiki"], name: "index_words_on_existing_in_wiki", using: :btree
  add_index "words", ["uploaded_to_wiki"], name: "index_words_on_uploaded_to_wiki", using: :btree
  add_index "words", ["word"], name: "index_words_on_word", unique: true, using: :btree

end
