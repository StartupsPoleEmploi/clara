class RecallMailer < ApplicationMailer

  def contact_email
    @aid_name = params[:aid_name] 
    @aid_status = params[:aid_status] 
    @email_target = params[:email_target] 
    mail(
      subject: "[Clara] vous avez une aide à vérifier !",
      from: ENV['ARA_EMAIL_FROM'],
      to: @email_target,
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
