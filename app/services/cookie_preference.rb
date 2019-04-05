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
    @s[:cookie] && @s[:cookie]["analytics"] && @s[:cookie]["analytics"] == "forbid_statistic"
  end

  def hj_disabled?
    print "***************** COOKIE *************************"
    print "***************** COOKIE *************************"
    print @s[:cookie]
    print "***************** COOKIE HJ*************************"
    print "***************** COOKIE HJ*************************"
    print @s[:cookie]["hotjar"]
    res = @s[:cookie] && @s[:cookie]["hotjar"] && @s[:cookie]["hotjar"] == "forbid_navigation"
    #print "***************** RES*************************"
    #print "***************** RES*************************"
    #print res
    res
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
