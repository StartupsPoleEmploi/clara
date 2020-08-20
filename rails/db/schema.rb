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

ActiveRecord::Schema.define(version: 2020_08_17_085355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "aids", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "what"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "short_description"
    t.text "how_much"
    t.text "additionnal_conditions"
    t.text "how_and_when"
    t.text "limitations"
    t.bigint "rule_id"
    t.integer "ordre_affichage"
    t.bigint "contract_type_id"
    t.datetime "archived_at"
    t.text "source"
    t.string "status"
    t.boolean "is_rereadable", default: false
    t.index ["contract_type_id"], name: "index_aids_on_contract_type_id"
    t.index ["rule_id"], name: "index_aids_on_rule_id"
    t.index ["slug"], name: "index_aids_on_slug", unique: true
  end

  create_table "aids_filters", id: false, force: :cascade do |t|
    t.bigint "filter_id", null: false
    t.bigint "aid_id", null: false
  end

  create_table "api_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clockdiffs", force: :cascade do |t|
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compound_rules", id: :serial, force: :cascade do |t|
    t.integer "rule_id"
    t.integer "slave_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rule_id", "slave_rule_id"], name: "index_compound_rules_on_rule_id_and_slave_rule_id", unique: true
    t.index ["rule_id"], name: "index_compound_rules_on_rule_id"
    t.index ["slave_rule_id"], name: "index_compound_rules_on_slave_rule_id"
  end

  create_table "contract_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordre_affichage"
    t.string "icon"
    t.string "slug"
    t.string "category"
    t.string "plural"
    t.index ["slug"], name: "index_contract_types_on_slug", unique: true
  end

  create_table "conventions", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_rule_checks", force: :cascade do |t|
    t.bigint "rule_id"
    t.string "result"
    t.string "name"
    t.text "hsh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rule_id"], name: "index_custom_rule_checks_on_rule_id"
  end

  create_table "explicitations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "template"
    t.bigint "variable_id"
    t.string "operator_kind"
    t.string "value_eligible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variable_id"], name: "index_explicitations_on_variable_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "content"
    t.string "positive"
    t.string "url_of_detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filters", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "slug"
    t.integer "ordre_affichage"
    t.text "icon", default: "<svg width=\"80\" height=\"80\" class=\"default-svg\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 500 500\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" enable-background=\"new 0 0 100 100\"><g><g><path d=\"m197.2,311.2c6.2-4.2 12.5-6.2 19.8-6.2 7.3,0 13.5,1 18.7,3.1 5.2,2.1 10.4,6.2 15.6,12.5l13.5-16.6c-11.4-14.7-28.1-22-47.8-22-13.5,0-26,4.2-36.4,12.5-10.4,8.3-17.7,18.7-21.8,32.3h-19.8v16.6 1h15.6c-0.2,8.1 1,12.5 1,15.6h-16.6v16.6h20.8c4.2,12.5 11.4,22.9 21.8,30.2 10.4,7.3 21.8,11.4 35.4,11.4 19.8,0 35.4-7.3 46.8-21.8l-13.5-16.6c-5.2,6.2-10.4,10.4-15.6,12.5-5.2,3.1-10.4,4.2-17.7,4.2-14.6,0-23.9-6.2-31.2-19.8h43.7v-16.6h-48.9c-1-2.1-1.7-11-1-15.6h48.9v-16.6h-44.7c3-7.4 7.2-12.6 13.4-16.7z\"></path><path d=\"M325.2,11.5H70.3v489h370.4l0-373.5L325.2,11.5z M406.3,121.8h-74.9V46.9L406.3,121.8z M90,479.7V32.3h220.6v98.8 c0,6.2,5.2,10.4,10.4,10.4h99.9v338.1H90z\"></path></g></g></svg>"
    t.boolean "is_hidden", default: false
    t.string "author"
    t.integer "ordre_affichage_home"
    t.string "illustration_file_name"
    t.string "illustration_content_type"
    t.bigint "illustration_file_size"
    t.datetime "illustration_updated_at"
    t.index ["slug"], name: "index_filters_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "offpeconnects", force: :cascade do |t|
    t.string "value", default: "off"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recalls", force: :cascade do |t|
    t.datetime "trigger_at"
    t.bigint "aid_id"
    t.string "email"
    t.string "status", default: "not_sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid_id"], name: "index_recalls_on_aid_id"
  end

  create_table "rules", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "value_eligible"
    t.integer "composition_type"
    t.integer "variable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "value_ineligible"
    t.string "kind"
    t.string "operator_kind"
    t.string "simulated"
    t.index ["variable_id"], name: "index_rules_on_variable_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "traces", force: :cascade do |t|
    t.string "url"
    t.string "user"
    t.bigint "tracing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "geo"
    t.index ["tracing_id"], name: "index_traces_on_tracing_id"
  end

  create_table "tracings", force: :cascade do |t|
    t.text "description"
    t.string "name"
    t.boolean "all_aids"
    t.bigint "rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rule_id"], name: "index_tracings_on_rule_id"
  end

  create_table "tracizations", force: :cascade do |t|
    t.bigint "tracing_id"
    t.bigint "aid_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid_id"], name: "index_tracizations_on_aid_id"
    t.index ["tracing_id"], name: "index_tracizations_on_tracing_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "role", default: "contributeur"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "variables", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "elements"
    t.text "name_translation"
    t.text "elements_translation"
    t.boolean "is_visible", default: true
    t.string "variable_kind"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "zrrs", force: :cascade do |t|
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "aids", "contract_types"
  add_foreign_key "compound_rules", "rules"
  add_foreign_key "compound_rules", "rules", column: "slave_rule_id"
  add_foreign_key "custom_rule_checks", "rules"
  add_foreign_key "explicitations", "variables"
  add_foreign_key "recalls", "aids"
  add_foreign_key "rules", "variables"
end
