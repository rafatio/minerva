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

ActiveRecord::Schema.define(version: 2019_04_06_202707) do

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

  create_table "application_count_options", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_application_count_options_on_name"
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.integer "user_id"
    t.integer "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.integer "creator_id"
    t.integer "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.integer "dashboard_id"
    t.integer "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.integer "creator_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.integer "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "run_role_id"
    t.integer "update_role_id"
    t.integer "delete_role_id"
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
    t.index ["delete_role_id"], name: "index_blazer_queries_on_delete_role_id"
    t.index ["run_role_id"], name: "index_blazer_queries_on_run_role_id"
    t.index ["update_role_id"], name: "index_blazer_queries_on_update_role_id"
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

  create_table "exchange_applications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "dre", null: false
    t.string "email", null: false
    t.string "cpf", null: false
    t.datetime "birth_date", null: false
    t.integer "ufrj_poli_course_id", null: false
    t.string "transcript_link", null: false
    t.string "resume_link", null: false
    t.string "enrollment_statement_link", null: false
    t.string "crid_link", null: false
    t.string "video_link", null: false
    t.boolean "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ufrj_poli_course_id"], name: "index_exchange_applications_on_ufrj_poli_course_id"
    t.index ["user_id"], name: "index_exchange_applications_on_user_id"
  end

  create_table "financial_aid_applications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "document", null: false
    t.string "email", null: false
    t.string "cpf", null: false
    t.datetime "birth_date", null: false
    t.integer "ufrj_poli_course_id", null: false
    t.string "dre", null: false
    t.string "address", null: false
    t.integer "state_id", null: false
    t.string "city", null: false
    t.decimal "per_capita_income", null: false
    t.boolean "quota_student", null: false
    t.boolean "receives_other_aids", null: false
    t.integer "residence_companion_id", null: false
    t.integer "family_members", null: false
    t.boolean "family_member_in_graduation", null: false
    t.integer "housing_condition_id", null: false
    t.boolean "medical_conditions", null: false
    t.boolean "family_member_medical_conditions", null: false
    t.boolean "atypical_family_situation", null: false
    t.decimal "gpa", null: false
    t.integer "extension_project_count_id"
    t.integer "national_olympics_middle_school_bronze_medals", null: false
    t.integer "national_olympics_middle_school_silver_medals", null: false
    t.integer "national_olympics_middle_school_golden_medals", null: false
    t.integer "international_olympics_middle_school_honorable_mentions", null: false
    t.integer "international_olympics_middle_school_bronze_medals", null: false
    t.integer "international_olympics_middle_school_silver_medals", null: false
    t.integer "international_olympics_middle_school_golden_medals", null: false
    t.string "video_link", null: false
    t.boolean "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extension_project_count_id"], name: "index_financial_aid_applications_on_extension_project_count_id"
    t.index ["housing_condition_id"], name: "index_financial_aid_applications_on_housing_condition_id"
    t.index ["residence_companion_id"], name: "index_financial_aid_applications_on_residence_companion_id"
    t.index ["state_id"], name: "index_financial_aid_applications_on_state_id"
    t.index ["ufrj_poli_course_id"], name: "index_financial_aid_applications_on_ufrj_poli_course_id"
    t.index ["user_id"], name: "index_financial_aid_applications_on_user_id"
  end

  create_table "financial_aid_applications_aids", id: false, force: :cascade do |t|
    t.integer "financial_aid_id", null: false
    t.integer "financial_aid_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financial_aids", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_financial_aids_on_name"
  end

  create_table "housing_conditions", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_housing_conditions_on_name"
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

  create_table "residence_companions", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_residence_companions_on_name"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer "country_id"
    t.string "name", null: false
    t.string "code", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "ufrj_poli_courses", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_ufrj_poli_courses_on_name"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
