class ErrorsController < ApplicationController
  def not_found
    render(:status => 404, :layout => false)
  end

  def internal_server_error
    render(:status => 500, :layout => false)
  end
end
