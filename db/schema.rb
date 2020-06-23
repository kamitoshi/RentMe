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

ActiveRecord::Schema.define(version: 2020_06_23_024213) do

  create_table "employers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "store_name", null: false
    t.string "kana_store_name", null: false
    t.string "manager_name"
    t.string "kana_manager_name"
    t.string "phone_number", null: false
    t.string "postal_code", null: false
    t.integer "prefecture", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building"
    t.text "introduction"
    t.string "image"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_employers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_employers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_employers_on_unlock_token", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.integer "worker_id"
    t.integer "prefecture"
    t.string "city"
    t.string "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["worker_id"], name: "index_locations_on_worker_id"
  end

  create_table "suggest_types", force: :cascade do |t|
    t.integer "suggest_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suggest_id"], name: "index_suggest_types_on_suggest_id"
    t.index ["type_id"], name: "index_suggest_types_on_type_id"
  end

  create_table "suggests", force: :cascade do |t|
    t.integer "worker_id"
    t.string "title", null: false
    t.text "detail", null: false
    t.string "price", null: false
    t.date "target_date", null: false
    t.time "opening", null: false
    t.time "closing", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["closing"], name: "index_suggests_on_closing"
    t.index ["opening"], name: "index_suggests_on_opening"
    t.index ["target_date"], name: "index_suggests_on_target_date"
    t.index ["title"], name: "index_suggests_on_title"
    t.index ["worker_id"], name: "index_suggests_on_worker_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "kana_last_name", null: false
    t.string "kana_first_name", null: false
    t.integer "sex", null: false
    t.date "birthday", null: false
    t.string "phone_number", null: false
    t.string "postal_code", null: false
    t.integer "prefecture", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building"
    t.text "introduction"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_workers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["first_name"], name: "index_workers_on_first_name"
    t.index ["kana_first_name"], name: "index_workers_on_kana_first_name"
    t.index ["kana_last_name"], name: "index_workers_on_kana_last_name"
    t.index ["last_name"], name: "index_workers_on_last_name"
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_workers_on_unlock_token", unique: true
  end

end
