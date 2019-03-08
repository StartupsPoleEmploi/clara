require "administrate/base_dashboard"

class TracingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    traces: Field::HasMany,
    aids:   Field::HasMany,
    rule: Field::BelongsTo,
    id: Field::Number,
    description: Field::Text,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :traces,
    :rule,
    :aids,
    :id,
    :description,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :traces,
    :aids,
    :rule,
    :id,
    :description,
    :name,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :traces,
    :rule,
    :aids,
    :description,
    :name,
  ].freeze

  # Overwrite this method to customize how tracings are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tracing)
  #   "Tracing ##{tracing.id}"
  # end
end
