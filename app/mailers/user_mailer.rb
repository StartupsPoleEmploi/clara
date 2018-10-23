class UserMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    # mail(from: ENV['ARA_EMAIL_USER'], reply_to: @contact.email, to: ENV['ARA_EMAIL_DESTINATION'], subject: "Demande de contact via le site clara")
    mail(
      to: ENV['ARA_EMAIL_DESTINATION'],
      bcc: ENV['ARA_EMAIL_BCC'],
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
