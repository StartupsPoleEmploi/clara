class ContactController < ApplicationController
  

  def index
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(allowed_params)
    p '- - - - - - - - - - - - - - @contact- - - - - - - - - - - - - - - -' 
    pp @contact
    p ''
    redirect_to contact_sent_index_path
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
