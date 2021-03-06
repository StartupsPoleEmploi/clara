require "administrate/base_dashboard"

class AnswerDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    handicap: Field::String,
    spectacle: Field::String,
    cadre: Field::String,
    diplome: Field::String,
    category: Field::String,
    duree_d_inscription: Field::String,
    allocation_value_min: Field::String,
    allocation_type: Field::String,
    age: Field::String,
    location_citycode: Field::String,
    location_zipcode: Field::String,
    created_at: Field::DateTime.with_options(format: "%b %Y"),
    updated_at: Field::DateTime.with_options(export: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  handicap
  spectacle
  cadre
  diplome
  category
  duree_d_inscription
  allocation_value_min
  allocation_type
  age
  location_citycode
  location_zipcode
  created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  handicap
  spectacle
  cadre
  diplome
  category
  duree_d_inscription
  allocation_value_min
  allocation_type
  age
  location_citycode
  location_zipcode
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  handicap
  spectacle
  cadre
  diplome
  category
  duree_d_inscription
  allocation_value_min
  allocation_type
  age
  location_citycode
  location_zipcode
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how answers are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(answer)
  #   "Answer ##{answer.id}"
  # end
end
