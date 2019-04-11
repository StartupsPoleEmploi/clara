require 'active_support/deprecation'

class PasswordsController < Clearance::PasswordsController

  skip_before_action :require_login,
    only: [:create, :edit, :new, :update],
    raise: false
  skip_before_action :authorize,
    only: [:create, :edit, :new, :update],
    raise: false
  before_action :ensure_existing_user, only: [:edit, :update]

  def create
    if user = find_user_for_create
      user.forgot_password!
      deliver_email(user)
    end
    render template: 'passwords/create'
  end

  def edit
    @user = find_user_for_edit

    if params[:token]
      session[:password_reset_token] = params[:token]
      redirect_to url_for
    else
      render template: 'passwords/edit'
    end
  end

  def new
    render template: 'passwords/new'
  end

  def update
    @user = find_user_for_update

    password = password_reset_params

    error_message = password_is_complex_enough(password)

    if error_message.blank?
      @user.update_password(password)
      sign_in @user
      redirect_to url_after_update
      session[:password_reset_token] = nil
    else
      flash.now[:notice] = error_message
      render template: 'passwords/edit'
    end
  end

  private

  def password_is_complex_enough(password)
    message = ""
    if password.blank?
      message = "Le mot de passe ne peut être vide."
    elsif password.size < 8
      message = "Le mot de passe doit avoir au moins 8 caractères."
    elsif !password.match(/[a-z]/)
      message = "Le mot de passe doit avoir au moins une minuscule."
    elsif !password.match(/[A-Z]/)
      message = "Le mot de passe doit avoir au moins une majuscule."
    elsif !password.match(/\d/)
      message = "Le mot de passe doit avoir au moins un chiffre."
    elsif !password.match(/\W/)
      message = "Le mot de passe doit avoir au moins un caractère spécial."
    end
    message
  end

  def deliver_email(user)
    mail = ::ClearanceMailer.change_password(user)

    if mail.respond_to?(:deliver_later)
      mail.deliver_later
    else
      mail.deliver
    end
  end

  def password_reset_params
    if params.has_key? :user
      ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
      params[:user][:password]
    else
      params[:password_reset][:password]
    end
  end

  def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = params[:token] || session[:password_reset_token]

    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[user_param], token.to_s
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def ensure_existing_user
    unless find_user_by_id_and_confirmation_token
      flash_failure_when_forbidden
      render template: "passwords/new"
    end
  end

  def flash_failure_when_forbidden
    flash.now[:notice] = translate(:forbidden,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_when_forbidden'))
  end

  def flash_failure_after_update
    flash.now[:notice] = translate(:blank_password,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_after_update'))
  end

  def url_after_create
    sign_in_url
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end
end
