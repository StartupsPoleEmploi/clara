require "administrate/base_dashboard"

class RuleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    slave_rules: Field::HasMany.with_options(class_name: "Rule"),
    variable: Field::BelongsTo,
    aids: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    value_eligible: Field::String,
    value_ineligible: Field::String,
    operator_type: EnumField,
    composition_type: EnumField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :variable,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :slave_rules,
    :variable,
    :id,
    :name,
    :description,
    :value_eligible,
    :value_ineligible,
    :operator_type,
    :composition_type,
    :created_at,
    :updated_at,
    :aids,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :variable,
    :operator_type,
    :value_eligible,
    :value_ineligible,
    :slave_rules,
    :composition_type,
    :aids,
  ].freeze

  # Overwrite this method to customize how rules are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(rule)
    "Rule ##{rule.name}"
  end
end
