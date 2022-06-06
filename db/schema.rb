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

ActiveRecord::Schema[7.0].define(version: 2022_06_06_212737) do
  create_table "employees", force: :cascade do |t|
    t.string "employee_id_card", null: false
    t.integer "employee_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "requester_name"
    t.string "requester_extension"
    t.string "requester_phone"
    t.string "requester_id"
    t.string "requester_mail"
    t.string "requester_type"
    t.string "student_id"
    t.string "student_assosiation"
    t.string "work_location"
    t.string "work_building"
    t.string "work_type"
    t.text "work_description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
  end

  add_foreign_key "user_accounts", "employees", on_delete: :cascade
end
