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

ActiveRecord::Schema[7.1].define(version: 2024_05_29_010545) do
  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.integer "question_id", null: false
    t.integer "participation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_answers_on_participation_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_participations_on_game_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_questions_on_game_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "score"
    t.string "outcome"
    t.integer "participation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_results_on_participation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "participations"
  add_foreign_key "answers", "questions"
  add_foreign_key "participations", "games"
  add_foreign_key "participations", "users"
  add_foreign_key "questions", "games"
  add_foreign_key "results", "participations"
end
