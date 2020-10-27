class CustomClearanceMailer < ActionMailer::Base
  def change_password(email, magic_link)
    @email = email
    @magic_link = magic_link
    mail(
      from: Clearance.configuration.mailer_sender,
      to: @email,
      subject: I18n.t(
        :change_password,
        scope: [:clearance, :models, :clearance_mailer]
      ),
    )
  end
end
