class UserMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(from: @contact.email, to: ENV['ARA_EMAIL_DESTINATION'], subject: "Demande de contact via le site clara")
  end

end
