class UserMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(from: ENV['ARA_EMAIL_USER'], reply_to: @contact.email, to: ENV['ARA_EMAIL_CC'], subject: "Demande de contact via le site clara")
  end

end
