require 'uri'
require 'securerandom'

class CookiePreference

  def initialize(current_session)
    @s = current_session
  end    

  def cookie_preference_already_defined?
    @s[:cookie] != nil
  end

  def ga_disabled?
    @s[:cookie].try(:[], "analytics") != "authorize_statistic"
  end

  def accept_all_cookies
    @s[:cookie] = {
     "analytics" => "authorize_statistic",
    }
  end

  def set_preference(preference)
    @s[:cookie] = preference
  end

end
