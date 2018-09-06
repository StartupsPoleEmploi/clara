class ContactController < ApplicationController
  

  def index
    p '- - - - - - - - - - - - - - index- - - - - - - - - - - - - - - -' 
    p ''
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(allowed_params)
    p '- - - - - - - - - - - - - - @contact- - - - - - - - - - - - - - - -' 
    pp @contact
    p ''
    if @contact.valid?
      redirect_to contact_sent_index_path
    else
      flash[:error] = @contact.errors.messages
      flash[:contact] = @contact.errors.messages
      render :index
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
