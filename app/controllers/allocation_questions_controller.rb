class AllocationQuestionsController < ApplicationController

  before_action :require_asker, only: [:new, :create]
  
  def new
    @allocation = new_and_download(@asker)
  end

  def create
    @allocation = new_from_params
    if @allocation.valid?
      populate_asker
      save_asker
      redirect_to_next_question(request)
    else
      populate_errors(flash)
      redirect_to_same_page
    end
  end

private

  def redirect_to_same_page
    redirect_to new_allocation_question_path
  end

  def populate_errors(flash)
    flash[:error] = @allocation.errors.messages.values.flatten
  end

  def redirect_to_next_question(request)
    redirect_to QuestionManager.new.getNextPath(request.referer, @allocation)
  end

  def populate_asker
    AllocationService.new.upload(@allocation, @asker)
  end

  def new_and_download(asker)
    AllocationService.new.new_and_download(@asker)
  end

  def new_from_params
    AllocationForm.new(allowed_params)
  end

  def allowed_params
    params.require(:allocation_form).permit(:type).to_h if params[:allocation_form].present?
  end

end
