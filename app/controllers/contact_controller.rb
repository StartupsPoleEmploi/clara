class ContactController < ApplicationController
  

  def index
    @contact = ContactForm.new
  end

  def create
    p '- - - - - - - - - - - - - - @contact- - - - - - - - - - - - - - - -' 
    pp @contact
    p ''
    @contact = ContactForm.new(allowed_params)
    if @contact.valid?
      redirect_to contact_sent_index_path
    else
      flash[:error] = @contact.errors.messages
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
    ).to_h
  end

end
