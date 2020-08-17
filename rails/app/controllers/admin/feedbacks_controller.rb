module Admin
  class FeedbacksController < Admin::ApplicationController
    include AdministrateExportable::Exporter
  
    before_action :require_superadmin, only: [:update, :destroy, :edit]
    before_action :throw_security_error, only: [:update, :edit]


    def valid_action?(name, resource = resource_class)
      %w[new edit].exclude?(name.to_s) && super
    end

  end
end
