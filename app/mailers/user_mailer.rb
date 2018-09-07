class UserMailer < ApplicationMailer
  default from: ENV['ARA_EMAIL_USER']

  def welcome_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(to: ENV['ARA_EMAIL_DESTINATION'], subject: "Demande de contact via le site clara")
  end

end
