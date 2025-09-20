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

ActiveRecord::Schema[8.0].define(version: 2025_09_20_143459) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "link_clicks", force: :cascade do |t|
    t.bigint "short_link_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.index ["short_link_id"], name: "index_link_clicks_on_short_link_id"
  end

  create_table "link_preview_images", force: :cascade do |t|
    t.bigint "link_preview_id", null: false
    t.string "src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_preview_id"], name: "index_link_preview_images_on_link_preview_id"
  end

  create_table "link_previews", force: :cascade do |t|
    t.bigint "short_link_id", null: false
    t.string "title"
    t.text "description"
    t.string "favicon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_link_id"], name: "index_link_previews_on_short_link_id", unique: true
  end

  create_table "short_links", force: :cascade do |t|
    t.text "original_url", null: false
    t.string "shortcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["original_url"], name: "index_short_links_on_original_url", unique: true
    t.index ["shortcode"], name: "index_short_links_on_shortcode", unique: true
  end

  add_foreign_key "link_clicks", "short_links", on_delete: :cascade
  add_foreign_key "link_preview_images", "link_previews", on_delete: :cascade
  add_foreign_key "link_previews", "short_links", on_delete: :cascade
end
