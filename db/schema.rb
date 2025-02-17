# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_05_070411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.bigint "parent_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["project_id"], name: "index_comments_on_project_id"
  end

  create_table "project_events", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "eventable_type", null: false
    t.bigint "eventable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_type", "eventable_id"], name: "index_project_events_on_eventable"
    t.index ["project_id"], name: "index_project_events_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "current_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_changes", force: :cascade do |t|
    t.string "old_status"
    t.string "new_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
  end

  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "projects"
  add_foreign_key "project_events", "projects"
end
