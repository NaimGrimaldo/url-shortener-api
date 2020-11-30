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

ActiveRecord::Schema.define(version: 2020_11_30_123005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: :cascade do |t|
    t.text "original_url", null: false
    t.bigint "user_id", null: false
    t.string "unique_key", limit: 10, null: false
    t.integer "visits", default: 0, null: false
    t.datetime "expires_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_links_on_deleted_at"
    t.index ["original_url"], name: "index_links_on_original_url"
    t.index ["unique_key"], name: "index_links_on_unique_key", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

  create_table "visitor_agents", force: :cascade do |t|
    t.string "agent"
    t.string "os"
    t.bigint "visitor_id", null: false
    t.integer "visits", default: 0
    t.datetime "visited_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_visitor_agents_on_deleted_at"
    t.index ["visitor_id"], name: "index_visitor_agents_on_visitor_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.bigint "link_id", null: false
    t.string "ip"
    t.integer "visitor_kind", default: 0
    t.integer "visits", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_visitors_on_deleted_at"
    t.index ["link_id"], name: "index_visitors_on_link_id"
  end

  add_foreign_key "links", "users"
  add_foreign_key "visitor_agents", "visitors"
  add_foreign_key "visitors", "links"
end
