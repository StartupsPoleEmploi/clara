class InscriptionQuestionsController < ApplicationController

  before_action :require_asker, only: [:new, :create]
  before_action :instantiate_service, only: [:new, :create]

  after_action :save_asker, only: [:create]
  
  def new
    @inscription = download_from_asker
  end

  def create
    if params[:commit] == 'Revenir' 
      my_redirect_to QuestionManager.new.getPreviousPath(request.referer, @asker)
    else
      inscription = download_from_params
      upload_to_asker(inscription)
      if inscription.valid?
        redirect_to_next_question(request, inscription)
      else
        populate_errors(flash, inscription)
        redirect_to_same_page
      end      
    end

  end
 
  private

  def redirect_to_same_page
    my_redirect_to new_inscription_question_path
  end

  def populate_errors(flash, inscription)
    flash[:error] = inscription.errors.messages.values.flatten
  end

  def redirect_to_next_question(request, inscription)
    my_redirect_to QuestionManager.new.getNextPath(request.referer, inscription)
  end

  def instantiate_service
    @service = InscriptionService.new(@asker)
  end

  def download_from_asker
    @service.download_from_asker
  end

  def upload_to_asker(inscription)
    @service.upload_to_asker(inscription)
  end

  def download_from_params
    InscriptionForm.new(allowed_params)
  end

  def allowed_params
    params.require(:inscription_form).permit(:value).to_h if params[:inscription_form].present?
  end
end
