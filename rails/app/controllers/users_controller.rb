class UsersController < Clearance::UsersController

  before_action :require_login, only: [:create, :new], raise: false
  before_action :require_superadmin_or_relecteur, only: [:create, :new], raise: false


  def require_superadmin_or_relecteur
    unless current_user.role == "superadmin" || current_user.role == "relecteur" 
      raise SecurityError, "Not Allowed"
    end
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create
    @user = user_from_params
    if @user.save
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private


  def redirect_signed_in_users
    false
  end

  def url_after_create
    "/admin/users?user[direction]=desc&user[order]=created_at"
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
