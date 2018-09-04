class ContactController < ApplicationController
  

  def index
  end

  def create
  end
  
  def allowed_params
    params.require(:contact_form).permit(:blabla).to_h
  end

end
