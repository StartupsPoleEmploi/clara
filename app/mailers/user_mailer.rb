class UserMailer < ApplicationMailer

  def contacts_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(
      subject: "Demande de contact via le site Clara",
      from: ENV['ARA_EMAIL_FROM'],
      to: ENV['ARA_EMAIL_DESTINATION'],
      cc: ENV['ARA_EMAIL_CC'],
      reply_to: @contact.email,
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
