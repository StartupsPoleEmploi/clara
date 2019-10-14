
module Admin
  class AidCreationController < Admin::ApplicationController

    def dashboard
      @dashboard ||= AidDashboard.new
    end

    def new_aid_stage_1
      resource = Aid.new
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }      
    end

  end
end
