class ContactController < ApplicationController
  

  def index
    @contact = ContactForm.new
  end

  def create
    p '- - - - - - - - - - - - - - create- - - - - - - - - - - - - - - -' 
    p ''
    @contact = ContactForm.new(allowed_params)
    p '- - - - - - - - - - - - - - @contact- - - - - - - - - - - - - - - -' 
    pp @contact
    p ''

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
