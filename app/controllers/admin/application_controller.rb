# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :set_locale
    before_action :authenticate_admin
    before_action :set_paper_trail_whodunnit 
    helper_method :current_user_email
    
 
    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end
     
    def extract_locale
      parsed_locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def default_url_options
      super.merge(
        locale: I18n.locale
      )
    end

    def authenticate_admin
      return if ENV['ARA_SKIP_ADMIN_AUTH']
      redirect_to signin_path unless current_user_email
    end

    # Overrides this so that
    def nav_link_state(resource)
      comparable = resource_name.to_s.pluralize
      comparable == resource.to_s ? :active : :inactive
    end

    protected
    def user_for_paper_trail
      current_user_email ? current_user_email : 'Inconnu'
    end

    private
    def current_user_email
      session[:user_email]
    end

  end
end
