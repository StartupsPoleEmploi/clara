class ContactController < ApplicationController
  

  def index
    @contact = ContactForm.new(flash[:contact])
  end

  def create
    @origin = request.host
    @contact = ContactForm.new(allowed_params)
    if @contact.valid?
      UserMailer.with(contact: @contact, origin: @origin).welcome_email.deliver_later
      redirect_to contact_sent_index_path
    else
      flash[:error] = @contact.errors.messages
      flash[:contact] = @contact.attributes
      redirect_to contact_index_path(@contact)
    end
  end
  
  def allowed_params
    params.require(:contact_form).permit(
     :first_name,
     :last_name,
     :email,
     :region,
     :youare,
     :askfor,
     :question,
     :honey,
    ).to_h
  end

end
