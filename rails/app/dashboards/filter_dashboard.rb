require "administrate/base_dashboard"

class FilterDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    avatar: Field::ActiveStorage,
    ordre_affichage: Field::Number,
    ordre_affichage_home: Field::Number,
    author: Field::String,
    name: Field::String,
    slug: Field::String,
    icon: Field::String,
    aids: Field::HasMany,
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
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :ordre_affichage,
    :aids,
    :name,
    :slug,
    :avatar,
    :author,
    :ordre_affichage_home,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :icon,
    :ordre_affichage,
    :aids,
    :avatar,
    :author,
    :ordre_affichage_home,
  ].freeze

  # Overwrite this method to customize how aidss are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(filter)
    filter.name
  end
  
end
