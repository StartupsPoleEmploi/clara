class RecallMailer < ApplicationMailer

  def recall_email
    @aid_name = params[:aid_name] 
    @aid_status = params[:aid_status] 
    @aid_link = params[:aid_link] 
    @email_target = params[:email_target]
    mail(
      subject: "[Clara] Vous avez une aide à vérifier !",
      from: ENV['ARA_EMAIL_FROM'],
      to: @email_target,
      delivery_method_options: { api_key: ENV['ARA_EMAIL_API_KEY'], secret_key: ENV['ARA_EMAIL_SECRET_KEY'] }
    )
  end

end
