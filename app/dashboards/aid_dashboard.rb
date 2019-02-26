require "administrate/base_dashboard"

class AidDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    name: Field::String,
    source: Field::String,
    ordre_affichage: Field::Number,
    archived_at: Field::DateTime,
    slug: Field::String,
    source: Field::String,
    rule: Field::BelongsTo,
    contract_type: Field::BelongsTo,
    need_filters: Field::HasMany,
    filters: Field::HasMany,
    custom_filters: Field::HasMany,
    id: Field::Number,
    short_description: Field::String,
    what: Field::Ckeditor,
    how_much: Field::Ckeditor, 
    additionnal_conditions: Field::Ckeditor,
    how_and_when: Field::Ckeditor,
    limitations: Field::Ckeditor,
    created_at: Field::DateTime,
    updated_at: AidLastUpdateField,

  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :contract_type,
    :ordre_affichage,
    :need_filters,
    :custom_filters,
    :filters,
    :updated_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :source,
    :need_filters,
    :filters,
    :ordre_affichage,
    :updated_at,
    :slug,
    :rule,
    :contract_type,
    :archived_at,
    :short_description,
    :what,
    :how_much,
    :additionnal_conditions,
    :how_and_when,
    :limitations,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :source,
    :contract_type,
    :ordre_affichage,
    :short_description,
    :filters,
    :custom_filters,
    :rule,
    :need_filters,
    :archived_at,
    :what,
    :how_much,
    :additionnal_conditions,
    :how_and_when,
    :limitations,
  ].freeze

  # Overwrite this method to customize how aids are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(aid)
    aid.name
  end
  
end
