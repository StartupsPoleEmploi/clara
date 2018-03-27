class SessionsController < ApplicationController

  def new
    redirect_to(session[:user_email] ? admin_root_path : google_oauth_path)
  end

  def create
    email = request.env["omniauth.auth"]["info"]["email"]
    if ENV['ARA_AUTH_ADMIN_USERS'] && ENV['ARA_AUTH_ADMIN_USERS'].split(',').include?(email)
      reset_session
      session[:user_email] = email
      begin
        session[:user_token] = request.env["omniauth.auth"]["credentials"]["token"]
      rescue Exception => e
        session[:user_token] = nil
      end
      flash[:success] = "Bienvenue #{email} !"
      redirect_to admin_root_path
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

end
