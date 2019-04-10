class SessionsController < Clearance::SessionsController
  
  before_action :redirect_signed_in_users, only: [:new]
  skip_before_action :require_login,
    only: [:create, :new, :destroy],
    raise: false
  skip_before_action :authorize,
    only: [:create, :new, :destroy],
    raise: false

  def create

    set_remember_me

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
    sign_out
    redirect_to url_after_destroy
  end

  def new
    render template: "sessions/new"
  end

  private

  def set_remember_me
    if params["session"]["remember_me"] == "1"
      cookies.permanent[:remember_me] = true
    elsif params["session"]["remember_me"] == "0"
      cookies.delete(:remember_me)
    end
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def url_after_destroy
    sign_in_url
  end

  def url_for_signed_in_users
    url_after_create
  end
end
