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

ActiveRecord::Schema[7.0].define(version: 2023_02_03_193005) do
  create_table "campus", force: :cascade do |t|
    t.string "campus_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "employee_id_card", null: false
    t.integer "employee_status", null: false
    t.integer "employee_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campus_id"
    t.index ["campus_id"], name: "index_employees_on_campus_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "observations", limit: 500
    t.integer "satisfaction"
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_feedbacks_on_request_id"
  end

  create_table "log_entries", force: :cascade do |t|
    t.integer "user_account_id", null: false
    t.integer "request_id", null: false
    t.string "entry_message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_log_entries_on_request_id"
    t.index ["user_account_id"], name: "index_log_entries_on_user_account_id"
  end

  create_table "reopen_reasons", force: :cascade do |t|
    t.string "reason", null: false
    t.integer "user_account_id", null: false
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_reopen_reasons_on_request_id"
    t.index ["user_account_id"], name: "index_reopen_reasons_on_user_account_id"
  end

  create_table "request_deny_reasons", force: :cascade do |t|
    t.string "reason", null: false
    t.integer "request_id", null: false
    t.integer "user_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_request_deny_reasons_on_request_id"
    t.index ["user_account_id"], name: "index_request_deny_reasons_on_user_account_id"
  end

  create_table "request_locations", force: :cascade do |t|
    t.string "name"
    t.integer "work_location_id"
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_building_id"
    t.index ["request_id"], name: "index_request_locations_on_request_id"
    t.index ["work_building_id"], name: "index_request_locations_on_work_building_id"
    t.index ["work_location_id"], name: "index_request_locations_on_work_location_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "requester_name", null: false
    t.string "requester_extension", null: false
    t.string "requester_phone", null: false
    t.string "requester_id", null: false
    t.string "requester_mail", null: false
    t.string "requester_type", null: false
    t.string "student_id"
    t.string "student_association"
    t.string "work_type", null: false
    t.text "work_description", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campus_id"
    t.string "identifier", null: false
    t.index ["campus_id"], name: "index_requests_on_campus_id"
  end

  create_table "task_observations", force: :cascade do |t|
    t.text "description", null: false
    t.integer "task_id", null: false
    t.integer "user_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_observations_on_task_id"
    t.index ["user_account_id"], name: "index_task_observations_on_user_account_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "assigned_at"
    t.string "status", default: "pending", null: false
    t.integer "employee_id", null: false
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["employee_id"], name: "index_tasks_on_employee_id"
    t.index ["request_id"], name: "index_tasks_on_request_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id", null: false
    t.index ["confirmation_token"], name: "index_user_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["employee_id"], name: "index_user_accounts_on_employee_id"
    t.index ["reset_password_token"], name: "index_user_accounts_on_reset_password_token", unique: true
  end

  create_table "work_buildings", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campus_id"
    t.index ["campus_id"], name: "index_work_buildings_on_campus_id"
  end

  create_table "work_locations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "work_building_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_building_id"], name: "index_work_locations_on_work_building_id"
  end

  add_foreign_key "employees", "campus", column: "campus_id"
  add_foreign_key "feedbacks", "requests"
  add_foreign_key "log_entries", "requests"
  add_foreign_key "log_entries", "user_accounts"
  add_foreign_key "reopen_reasons", "requests"
  add_foreign_key "reopen_reasons", "user_accounts"
  add_foreign_key "request_deny_reasons", "requests"
  add_foreign_key "request_deny_reasons", "user_accounts"
  add_foreign_key "request_locations", "requests"
  add_foreign_key "request_locations", "work_buildings"
  add_foreign_key "request_locations", "work_locations"
  add_foreign_key "requests", "campus", column: "campus_id"
  add_foreign_key "task_observations", "tasks"
  add_foreign_key "task_observations", "user_accounts"
  add_foreign_key "tasks", "employees"
  add_foreign_key "tasks", "requests"
  add_foreign_key "user_accounts", "employees"
  add_foreign_key "work_buildings", "campus", column: "campus_id"
  add_foreign_key "work_locations", "work_buildings"
end
