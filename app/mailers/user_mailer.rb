class UserMailer < ApplicationMailer
  default from: ENV['ARA_EMAIL_USER']
 
  def welcome_email
    mail(to: ENV['ARA_EMAIL_DESTINATION'], subject: "Welcome to stuff")
  end
end
