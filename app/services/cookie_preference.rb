require 'uri'
require 'securerandom'

class CookiePreference

  def initialize(current_session)
    @s = current_session
  end    

  def cookie_preference_already_defined?
    print "***************** COOKIE *************************"
    print "***************** COOKIE *************************"
    print "***************** COOKIE *************************"
    print "***************** COOKIE *************************"
    res = @s[:cookie] != nil
    print res
    res
  end

  def ga_disabled?
    @s[:cookie] && @s[:cookie]["analytics"] && @s[:cookie]["analytics"] == "forbid_statistic"
  end

  def hj_disabled?
    @s[:cookie] && @s[:cookie]["hotjar"] && @s[:cookie]["hotjar"] == "forbid_navigation"
  end

  def accept_all_cookies
    @s[:cookie] = {
     "analytics" => "authorize_statistic",
     "hotjar" => "authorize_navigation",
    }
  end

  def set_preference(preference)
    @s[:cookie] = preference
  end

end
