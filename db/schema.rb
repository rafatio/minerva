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

ActiveRecord::Schema.define(version: 2019_08_08_215855) do

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "country_id"
    t.integer "state_id"
    t.string "state_name"
    t.string "zip_code"
    t.string "city"
    t.string "number"
    t.string "complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "street"
    t.string "neighborhood"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "contact_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contact_type_id"
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "preferred"
    t.index ["contact_type_id"], name: "index_contacts_on_contact_type_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order_index"
  end

  create_table "education_informations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "education_level_id", null: false
    t.string "institution", null: false
    t.string "course", null: false
    t.integer "conclusion_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["education_level_id"], name: "index_education_informations_on_education_level_id"
    t.index ["user_id"], name: "index_education_informations_on_user_id"
  end

  create_table "education_levels", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "intended_relationships", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "associate"
    t.boolean "financial"
    t.boolean "mentoring"
    t.boolean "tutoring"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_intended_relationships_on_user_id"
  end

  create_table "payment_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "value", precision: 8, scale: 2
    t.text "pagarme_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subscription_id"
    t.integer "payment_type_id"
    t.index ["payment_type_id"], name: "index_payments_on_payment_type_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.datetime "birth_date", null: false
    t.string "gender", null: false
    t.string "cpf", null: false
    t.string "rg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "previous_companies", force: :cascade do |t|
    t.integer "professional_information_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_information_id"], name: "index_previous_companies_on_professional_information_id"
  end

  create_table "professional_informations", force: :cascade do |t|
    t.integer "user_id"
    t.string "company", null: false
    t.string "position", null: false
    t.integer "admission_year"
    t.decimal "salary", precision: 12, scale: 2
    t.decimal "estimated_wealth", precision: 16, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_professional_informations_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer "country_id"
    t.string "name", null: false
    t.string "code", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "value", precision: 8, scale: 2
    t.boolean "active", null: false
    t.text "pagarme_subscription"
    t.integer "pagarme_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.boolean "agreement"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
