# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def contacts_email
    @contact = ContactForm.new(
      # Manually faked from https://github.com/stympy/faker#usage
      first_name: "Christophe",
      last_name: "Bartell",
      email: "kirsten.greenholt@corkeryfisher.info",
      region: "BFC",
      youare: "entreprise",
      askfor: "signaler",
      question: "Un de vos liens est cassé. En effet on ne peut plus vous envoyer de message ! \"#{User.all}\""
    )
    @origin = "monsite.com"
    UserMailer.with(contact: @contact, origin: @origin).contacts_email
  end
end
