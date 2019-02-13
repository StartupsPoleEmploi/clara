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

ActiveRecord::Schema.define(version: 2018_12_10_103124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "plpgsql"

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
    t.index ["contract_type_id"], name: "index_aids_on_contract_type_id"
    t.index ["rule_id"], name: "index_aids_on_rule_id"
    t.index ["slug"], name: "index_aids_on_slug", unique: true
  end

  create_table "aids_custom_filters", id: false, force: :cascade do |t|
    t.bigint "custom_filter_id", null: false
    t.bigint "aid_id", null: false
  end

  create_table "aids_filters", id: false, force: :cascade do |t|
    t.bigint "filter_id", null: false
    t.bigint "aid_id", null: false
  end

  create_table "aids_need_filters", id: false, force: :cascade do |t|
    t.bigint "need_filter_id", null: false
    t.bigint "aid_id", null: false
  end

  create_table "axle_filters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "domain_filter_id"
    t.index ["domain_filter_id"], name: "index_axle_filters_on_domain_filter_id"
    t.index ["slug"], name: "index_axle_filters_on_slug", unique: true
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
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordre_affichage"
    t.string "icon"
    t.string "slug"
    t.string "category"
    t.string "plural"
    t.index ["slug"], name: "index_contract_types_on_slug", unique: true
  end

  create_table "custom_filters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "custom_parent_filter_id"
    t.index ["custom_parent_filter_id"], name: "index_custom_filters_on_custom_parent_filter_id"
    t.index ["slug"], name: "index_custom_filters_on_slug", unique: true
  end

  create_table "custom_parent_filters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_custom_parent_filters_on_slug", unique: true
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

  create_table "domain_filters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_domain_filters_on_slug", unique: true
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

  create_table "filters", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "slug"
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

  create_table "need_filters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "axle_filter_id"
    t.boolean "confidentiality", default: true
    t.index ["axle_filter_id"], name: "index_need_filters_on_axle_filter_id"
    t.index ["slug"], name: "index_need_filters_on_slug", unique: true
  end

  create_table "rule_checks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["variable_id"], name: "index_rules_on_variable_id"
  end

  create_table "stats", force: :cascade do |t|
    t.jsonb "ga", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "ga_pe", default: "{}"
    t.jsonb "hj_ad", default: "{}"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variables", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "variable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "elements"
    t.text "name_translation"
    t.text "elements_translation"
    t.boolean "is_visible", default: true
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
  add_foreign_key "axle_filters", "domain_filters"
  add_foreign_key "compound_rules", "rules"
  add_foreign_key "compound_rules", "rules", column: "slave_rule_id"
  add_foreign_key "custom_filters", "custom_parent_filters"
  add_foreign_key "custom_rule_checks", "rules"
  add_foreign_key "explicitations", "variables"
  add_foreign_key "need_filters", "axle_filters"
  add_foreign_key "rules", "variables"
end
