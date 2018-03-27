# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    before_action :set_paper_trail_whodunnit 
    helper_method :current_user_email

    def authenticate_admin
      return if ENV['ARA_SKIP_ADMIN_AUTH']
      redirect_to signin_path unless current_user_email
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
