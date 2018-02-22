class OtherQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]
  before_action :instantiate_service, only: [:new, :create]
 
  after_action :save_asker, only: [:create]
  
  def new
    @other = download_from_asker
  end

  def create
    @other = download_from_params
    if @other.valid?
      upload_to_asker(@other)
      redirect_to_next_question(request)
    else
      populate_errors(flash)
      redirect_to_same_page
    end
  end
 
  private

  def redirect_to_same_page
    redirect_to new_other_question_path
  end

  def redirect_to_next_question(request)
    base64_str = ConvertAskerInBase64Service.new.into_base64(@asker)
    redirect_to QuestionManager.new.getNextPath(request.referer, base64_str)
  end

  def populate_errors(flash)
    flash[:error] = @other.errors.messages.values.flatten
  end


  def upload_to_asker(other)
    @service.upload_to_asker(other)
  end

  def download_from_asker
    @service.download_from_asker
  end

  def download_from_params
    OtherForm.new(allowed_params)
  end

  def instantiate_service
    @service = OtherService.new(@asker)
  end

  def allowed_params
    params.require(:other_form).permit(:val_harki, :val_detenu, :val_pi, :val_handicap, :none).to_h if params[:other_form].present?
  end
  
end
