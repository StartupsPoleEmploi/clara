module Admin
  class FiltersController < Admin::ApplicationController

    before_action :require_superadmin
    

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      @actual_search_size = resources.size
      super
    end

    def destroy_attachment
      avatar = requested_resource.attachment.find(params[:attachment_id])
      avatar.purge
      render json: {
        status: 'ok'
      }
    end

    def find_resource(param)
      result = Filter.find_by(slug: param)
      result.blank? ? Filter.find_by(id: param) : result
    end

  end
end
