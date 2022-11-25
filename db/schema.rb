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

ActiveRecord::Schema.define(version: 2022_11_25_004154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string "cedula", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "office_id"
    t.index ["office_id"], name: "index_doctors_on_office_id"
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.text "comments"
    t.string "entry_type"
    t.date "date"
    t.bigint "meeting_id"
    t.bigint "office_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "weight"
    t.float "height"
    t.integer "bloodPressureSys"
    t.integer "bloodPressureDia"
    t.index ["meeting_id"], name: "index_entries_on_meeting_id"
    t.index ["office_id"], name: "index_entries_on_office_id"
    t.index ["patient_id"], name: "index_entries_on_patient_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.index ["doctor_id"], name: "index_meetings_on_doctor_id"
    t.index ["patient_id"], name: "index_meetings_on_patient_id"
  end

  create_table "offices", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "phone_number", default: ""
    t.string "address", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_id", null: false
    t.string "code", null: false
    t.time "open_hour"
    t.time "close_hour"
    t.index ["doctor_id"], name: "index_offices_on_doctor_id"
  end

  create_table "offices_patients", id: false, force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.bigint "office_id", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "weight", default: ""
    t.string "height", default: ""
    t.string "blood_type", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.text "body"
    t.date "date"
    t.bigint "meeting_id"
    t.bigint "office_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meeting_id"], name: "index_prescriptions_on_meeting_id"
    t.index ["office_id"], name: "index_prescriptions_on_office_id"
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "first_last_name", default: "", null: false
    t.string "second_last_name", default: "", null: false
    t.string "sex", default: "", null: false
    t.date "dob", null: false
    t.string "curp", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctors", "offices"
  add_foreign_key "doctors", "users"
  add_foreign_key "entries", "meetings"
  add_foreign_key "entries", "offices"
  add_foreign_key "entries", "patients"
  add_foreign_key "meetings", "doctors"
  add_foreign_key "meetings", "patients"
  add_foreign_key "offices", "doctors"
  add_foreign_key "patients", "users"
  add_foreign_key "prescriptions", "meetings"
  add_foreign_key "prescriptions", "offices"
  add_foreign_key "prescriptions", "patients"
end
