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

ActiveRecord::Schema.define(version: 2020_06_21_101942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awnsers", force: :cascade do |t|
    t.string "content"
    t.integer "score"
    t.bigint "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_awnsers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_awnsers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "awnser_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["awnser_id"], name: "index_user_awnsers_on_awnser_id"
    t.index ["user_id"], name: "index_user_awnsers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "highscore", default: 0
  end

  add_foreign_key "user_awnsers", "awnsers"
  add_foreign_key "user_awnsers", "users"
end
