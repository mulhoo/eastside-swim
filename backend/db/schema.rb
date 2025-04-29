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

ActiveRecord::Schema[8.0].define(version: 2025_04_29_012628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "practice_group_id"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "phone"
    t.string "prefered_contact_method", default: "email"
    t.date "date_of_birth"
    t.string "gender"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.boolean "active", default: true
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "last_name"], name: "index_athletes_on_organization_id_and_last_name"
    t.index ["organization_id"], name: "index_athletes_on_organization_id"
    t.index ["practice_group_id"], name: "index_athletes_on_practice_group_id"
  end

  create_table "event_entries", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "athlete_id", null: false
    t.string "competition_name", null: false
    t.integer "heat_number"
    t.integer "lane_number"
    t.string "team_color"
    t.string "result_time"
    t.integer "score"
    t.integer "placement"
    t.boolean "personal_best", default: false
    t.text "notes"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_event_entries_on_athlete_id"
    t.index ["event_id"], name: "index_event_entries_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "sport", null: false
    t.string "description"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "location"
    t.string "event_type"
    t.integer "status", default: 0
    t.string "event_url"
    t.string "event_image"
    t.string "organization_registration_url"
    t.datetime "registration_deadline"
    t.integer "number_of_participants"
    t.integer "capacity"
    t.boolean "is_public", default: true
    t.decimal "cost", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "host"
    t.bigint "organization_id", null: false
    t.bigint "sport_id"
    t.bigint "facility_id", null: false
    t.index ["facility_id"], name: "index_events_on_facility_id"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["sport_id"], name: "index_events_on_sport_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "country", null: false
    t.string "phone"
    t.string "website"
    t.text "description"
    t.integer "facility_type", default: 0, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_facilities", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_organization_facilities_on_facility_id"
    t.index ["organization_id", "facility_id"], name: "index_org_facilities", unique: true
    t.index ["organization_id"], name: "index_organization_facilities_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "country", null: false
    t.string "phone", null: false
    t.string "domain_name", null: false
    t.string "website_link", null: false
    t.string "logo"
    t.text "description"
    t.string "founded_year", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "certifications", default: [], array: true
    t.string "national_governing_body"
    t.string "regional_governing_body"
    t.bigint "sport_id"
    t.integer "organization_type", default: 0, null: false
    t.jsonb "team_site_settings", default: {}, null: false
    t.index ["domain_name"], name: "index_organizations_on_domain_name", unique: true
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["sport_id"], name: "index_organizations_on_sport_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "athlete_id"
    t.bigint "user_id"
    t.string "payment_type", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "due_date", null: false
    t.date "paid_date"
    t.boolean "paid", default: false
    t.string "payment_method"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_payments_on_athlete_id"
    t.index ["organization_id"], name: "index_payments_on_organization_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "practice_groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "organization_id", null: false
    t.string "practice_days", default: [], array: true
    t.integer "age_min", null: false
    t.integer "age_max", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_practice_groups_on_organization_id"
  end

  create_table "practice_times", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.integer "day_of_week", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.string "location_name", null: false
    t.string "location_address", null: false
    t.string "location_city", null: false
    t.string "location_state", null: false
    t.string "location_zip", null: false
    t.string "location_country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "practice_group_id", null: false
    t.text "note"
    t.bigint "facility_id", null: false
    t.index ["facility_id"], name: "index_practice_times_on_facility_id"
    t.index ["organization_id"], name: "index_practice_times_on_organization_id"
    t.index ["practice_group_id"], name: "index_practice_times_on_practice_group_id"
  end

  create_table "relay_team_athletes", force: :cascade do |t|
    t.bigint "relay_team_id", null: false
    t.bigint "athlete_id", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["athlete_id"], name: "index_relay_team_athletes_on_athlete_id"
    t.index ["relay_team_id"], name: "index_relay_team_athletes_on_relay_team_id"
  end

  create_table "relay_teams", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "team_name", null: false
    t.integer "heat_number"
    t.integer "lane_number"
    t.string "team_color"
    t.string "result_time"
    t.integer "placement"
    t.boolean "completed", default: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_relay_teams_on_event_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name", null: false
    t.string "category"
    t.string "seasonality"
    t.integer "individual_or_team", default: 0, null: false
    t.string "governing_body"
    t.string "official_website"
    t.text "description"
    t.string "rules_url"
    t.text "equipment_needed"
    t.string "icon_url"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sports_on_name", unique: true
  end

  create_table "tryouts", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "sport_id"
    t.string "name", null: false
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.string "location_name"
    t.string "location_address"
    t.string "location_city"
    t.string "location_state"
    t.string "location_zip"
    t.string "location_country"
    t.jsonb "form_structure", default: {}
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "facility_id"
    t.index ["facility_id"], name: "index_tryouts_on_facility_id"
    t.index ["organization_id"], name: "index_tryouts_on_organization_id"
    t.index ["sport_id"], name: "index_tryouts_on_sport_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone"
    t.integer "role", default: 0, null: false
    t.boolean "active", default: true
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "authentication_token_expires_at"
    t.string "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.string "profile_photo_url"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "athletes", "organizations"
  add_foreign_key "athletes", "practice_groups"
  add_foreign_key "event_entries", "athletes"
  add_foreign_key "event_entries", "events"
  add_foreign_key "events", "facilities"
  add_foreign_key "events", "organizations"
  add_foreign_key "events", "sports"
  add_foreign_key "organization_facilities", "facilities"
  add_foreign_key "organization_facilities", "organizations"
  add_foreign_key "organizations", "sports"
  add_foreign_key "payments", "athletes"
  add_foreign_key "payments", "organizations"
  add_foreign_key "payments", "users"
  add_foreign_key "practice_groups", "organizations"
  add_foreign_key "practice_times", "facilities"
  add_foreign_key "practice_times", "organizations"
  add_foreign_key "practice_times", "practice_groups"
  add_foreign_key "relay_team_athletes", "athletes"
  add_foreign_key "relay_team_athletes", "relay_teams"
  add_foreign_key "relay_teams", "events"
  add_foreign_key "tryouts", "facilities"
  add_foreign_key "tryouts", "organizations"
  add_foreign_key "tryouts", "sports"
  add_foreign_key "users", "organizations"
end
