require 'uri'
require 'securerandom'

class CookiePreference < ClaraService
  initialize_with_keywords :current_session
    

  def cookie_preference_already_defined?
    current_session[:cookie] != nil
  end

  def ga_disabled?
    current_session[:cookie] && current_session[:cookie]["analytics"] && current_session[:cookie]["analytics"] == "forbid_statistic"
  end

  def hj_disabled?
    current_session[:cookie] && current_session[:cookie]["hotjar"] && current_session[:cookie]["hotjar"] == "forbid_navigation"
  end

  def accept_all_cookies
    current_session[:cookie] = {
     "analytics" => "authorize_statistic",
     "hotjar" => "authorize_navigation",
    }
  end

end
