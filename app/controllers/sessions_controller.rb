class SessionsController < ApplicationController

  def new
    redirect_to(session[:user_email] ? admin_root_path : google_oauth_path)
  end

  def create
    token = extract_token_from(request)
    email = extract_email_from(request)
    if ENV['ARA_AUTH_ADMIN_USERS'] && ENV['ARA_AUTH_ADMIN_USERS'].split(',').include?(email)
      reset_session
      session[:user_email] = email
      session[:user_token] = token
      flash[:success] = "Bienvenue #{email} !"
      my_redirect_to admin_root_path
    else
      flash[:error] = 'Erreur d\'authentification'
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'Au revoir !'
    redirect_to root_url
  end

  def failure
    redirect_to root_url, error: 'Erreur d\'authentification : #{params[:message].humanize}'
  end

  private
  def extract_token_from(the_request)
    res = ""
    begin
      res = the_request.env["omniauth.auth"]["credentials"]["token"]
    rescue Exception => e
      res = ""
    end
    res
  end

  def extract_email_from(the_request)
    is_valid = 
    !!the_request && 
      the_request.respond_to?(:env) && 
      the_request.env["omniauth.auth"].is_a?(Hash) && 
      the_request.env["omniauth.auth"]["info"].is_a?(Hash)

     is_valid ? the_request.env["omniauth.auth"]["info"]["email"] : ""
  end

end
