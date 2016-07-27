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

ActiveRecord::Schema.define(version: 20160727151910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "date_ideas", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "description"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rating"], name: "index_date_ideas_on_rating", using: :btree
  end

  create_table "date_ideas_tags", force: :cascade do |t|
    t.integer  "date_idea_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["date_idea_id"], name: "index_date_ideas_tags_on_date_idea_id", using: :btree
    t.index ["tag_id"], name: "index_date_ideas_tags_on_tag_id", using: :btree
  end

  create_table "datelogs", force: :cascade do |t|
    t.string   "romantic_interest"
    t.datetime "rendezvous_time"
    t.string   "notes"
    t.integer  "date_idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
