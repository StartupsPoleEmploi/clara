module Admin
  class AnswersController < Admin::ApplicationController
    include AdministrateExportable::Exporter

    before_action :require_superadmin, only: [:destroy]

    def valid_action?(name, resource = resource_class)
      %w[new edit].exclude?(name.to_s) && super
    end
    
  end
end
