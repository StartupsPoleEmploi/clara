class ContactController < ApplicationController


  def index
    @errors = flash[:error] ? JSON.parse(flash[:error]) : {}
    @contact = ContactForm.new(flash[:contact])
  end

  def create
    @origin = (defined? request) && (request.respond_to?(:host)) ? request.host.to_s : "unknown"
    @contact = ContactForm.new(allowed_params)
    if @contact.valid?
      UserMailer.with(contact: @contact, origin: @origin).contact_email.deliver_now
      redirect_to contact_sent_index_path
    else
      flash[:error] = @contact.errors.messages.to_json
      flash[:contact] = @contact.attributes
      redirect_to contact_index_path
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
