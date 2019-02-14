require "administrate/base_dashboard"

class ExplicitationDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    slug: Field::String,
    variable: WithVariableField,
    operator_kind: EnumField,
    value_eligible: Field::String,
    template: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :variable,
    :operator_kind,
    :value_eligible,
    :template,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :slug,
    :variable,
    :operator_kind,
    :value_eligible,
    :template,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :name,
    :variable,
    :operator_kind,
    :value_eligible,
    :template,
  ].freeze

end
