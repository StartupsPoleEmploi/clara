require "administrate/base_dashboard"

class PeidDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(export: false),
    value: Field::String,
    created_at: Field::DateTime.with_options(format: "%b %Y"),
    updated_at: Field::DateTime.with_options(export: false),
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
  value
  created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
  id
  value
  created_at
  updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
  value
  ].freeze

  COLLECTION_FILTERS = {}.freeze

end
