require "administrate/base_dashboard"

class VariableDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    rule: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    name_translation: Field::Text,
    description: Field::Text,
    is_visible: Field::Boolean,
    elements: Field::Text,
    elements_translation: Field::Text,
    variable_kind: EnumField,
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
    :name_translation,
    :variable_kind,
    :description,
    :is_visible,
    :elements,
    :elements_translation,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :name_translation,
    :description,
    :is_visible,
    :elements,
    :elements_translation,
    :variable_kind,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name_translation,
    :variable_kind,
    :elements,
    :elements_translation,
    :description,
    :is_visible,
  ].freeze

  # Overwrite this method to customize how variables are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(variable)
    name = "#{variable.name}"
    translation = "#{variable.name_translation}"
    is_translated = !translation.blank?
    is_translated ? translation : name
  end
end
