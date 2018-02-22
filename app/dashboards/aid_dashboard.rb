require "administrate/base_dashboard"

class AidDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    ordre_affichage: Field::Number,
    last_update: Field::String,
    archived_at: Field::DateTime,
    slug: Field::String,
    rule: Field::BelongsTo,
    contract_type: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    short_description: Field::String,
    what: Field::Ckeditor,
    how_much: Field::Ckeditor, 
    additionnal_conditions: Field::Ckeditor,
    how_and_when: Field::Ckeditor,
    limitations: Field::Ckeditor,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,

  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :ordre_affichage,
    :last_update,
    :contract_type,
    :name,
    :short_description,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :ordre_affichage,
    :last_update,
    :slug,
    :rule,
    :contract_type,
    :name,
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
    :slug,
    :last_update,
    :archived_at,
    :rule,
    :contract_type,
    :ordre_affichage,
    :short_description,
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
