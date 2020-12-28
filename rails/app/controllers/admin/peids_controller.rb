module Admin
  class PeidsController < Admin::ApplicationController
    include AdministrateExportable::Exporter

    before_action :require_superadmin

    def valid_action?(name, resource = resource_class)
      %w[new edit show update edit].exclude?(name.to_s) && super
    end
    
  end
end
