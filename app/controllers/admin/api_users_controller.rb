module Admin
  class ApiUsersController < Admin::ApplicationController
    
    before_action :require_superadmin

  end
end
