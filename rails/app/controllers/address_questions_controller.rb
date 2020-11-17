class AddressQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]

  def new
    @address = AddressForm.new
    AddressService.new.download(@address, @asker)
  end

  def create
    @address = AddressForm.new(allowed_params)
    if @address.valid?
      if @address.label.present?
        AddressService.new.upload(@address, @asker)
      else
        AddressService.new.reset(@asker)
      end
      @asker.v_zrr = nil
      @asker.v_qpv = nil
      my_redirect_to QuestionManager.new.getNextPath('address', @age)
    else
      AddressService.new.reset(@asker)
      flash[:error] = @address.errors.messages.values.flatten
      my_redirect_to new_address_question_path
    end
  end

  def fake_ban_communes
    render json: JSON.parse('[{"nom":"Noyant-Villages","code":"49228","codeDepartement":"49","codeRegion":"52","codesPostaux":["49490","49390"],"population":5680},{"nom":"La Pellerine","code":"49237","codeDepartement":"49","codeRegion":"52","codesPostaux":["49490"],"population":145}]')
  end
  
private

  def allowed_params
    params.require(:address_form).permit(:label, :route, :city, :country, :citycode, :zipcode, :street_number, :state).to_h
  end

end
