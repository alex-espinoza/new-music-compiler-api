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

ActiveRecord::Schema.define(version: 20160204023642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "embed_data"
    t.string   "url"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "source_id"
    t.string   "image_url"
  end

  add_index "entries", ["source_id"], name: "index_entries_on_source_id", using: :btree

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.string   "parser_format"
    t.string   "url"
    t.datetime "last_checked_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "soundcloud_id"
  end

  add_foreign_key "entries", "sources"
end
