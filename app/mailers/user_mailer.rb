class UserMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact] 
    @origin = params[:origin] 
    mail(
      from: ENV['ARA_EMAIL_FROM'],
      to: ENV['ARA_EMAIL_DESTINATION'],
      cc: ENV['ARA_EMAIL_CC'],
      reply_to: @contact.email,
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
