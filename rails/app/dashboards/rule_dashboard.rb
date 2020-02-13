require "administrate/base_dashboard"

# HACK : not needed, but can't remove this class, or /admin/tracing/new won't display
class RuleDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {}.freeze

  COLLECTION_ATTRIBUTES = [].freeze

  SHOW_PAGE_ATTRIBUTES = [].freeze

  FORM_ATTRIBUTES = [].freeze


end
