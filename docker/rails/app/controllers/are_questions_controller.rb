class AreQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]
  
  def new
    @are = AreForm.new
    @are.minimum_income = @asker.v_allocation_value_min
  end

  def create
    if params[:commit] == 'Revenir' 
      my_redirect_to QuestionManager.new.getPreviousPath('are', @asker)
    else
      @are = AreForm.new(allowed_params)
      if @are.valid?
        @asker.v_allocation_value_min = @are.minimum_income
        my_redirect_to QuestionManager.new.getNextPath('are', @are)
      else
        flash[:error] = @are.errors.messages.values.flatten
        my_redirect_to new_are_question_path
      end
    end
  end

private

  def allowed_params
    params.require(:are_form).permit(:minimum_income).to_h
  end


end
