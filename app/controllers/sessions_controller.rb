class Clearance::SessionsController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:new]
    skip_before_action :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_action :authorize,
      only: [:create, :new, :destroy],
      raise: false
  else
    before_filter :redirect_signed_in_users, only: [:new]
    skip_before_filter :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_filter :authorize,
      only: [:create, :new, :destroy],
      raise: false
  end

  def create
    p '- - - - - - - - - - - - - - SessionsController#create- - - - - - - - - - - - - - - -' 
    p ''
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash.now.notice = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

  def destroy
    p '- - - - - - - - - - - - - - SessionsController#destroy- - - - - - - - - - - - - - - -' 
    p ''
    sign_out
    redirect_to url_after_destroy
  end

  def new
    p '- - - - - - - - - - - - - - SessionsController#new- - - - - - - - - - - - - - - -' 
    p ''
    render template: "sessions/new"
  end

  private

  def redirect_signed_in_users
    p '- - - - - - - - - - - - - - redirect_signed_in_users- - - - - - - - - - - - - - - -' 
    p ''
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    p '- - - - - - - - - - - - - - url_after_create- - - - - - - - - - - - - - - -' 
    p ''
    Clearance.configuration.redirect_url
  end

  def url_after_destroy
    p '- - - - - - - - - - - - - - url_after_destroy- - - - - - - - - - - - - - - -' 
    p ''
    sign_in_url
  end

  def url_for_signed_in_users
    p '- - - - - - - - - - - - - - url_for_signed_in_users- - - - - - - - - - - - - - - -' 
    p ''
    url_after_create
  end
end
