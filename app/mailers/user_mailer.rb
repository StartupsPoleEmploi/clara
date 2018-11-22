class UserMailer < ApplicationMailer

  def contact_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(
      subject: "Demande de contact via le site Clara",
      from: ENV['ARA_EMAIL_FROM'],
      to: ENV['ARA_EMAIL_BCC'],

      reply_to: @contact.email,
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
