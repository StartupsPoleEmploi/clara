class CategoryQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]  
  
  def new
    @category = CategoryForm.new
    @category.value = @asker.v_category 
  end

  def create
    if params[:commit] == 'Revenir' 
      my_redirect_to QuestionManager.new.getPreviousPath('category', @asker)
    else
      @category = CategoryForm.new(allowed_params)
      @asker.v_category = @category.value
      save_asker
      if @category.valid?
        my_redirect_to QuestionManager.new.getNextPath('category', @category)
      else
        flash[:error] = @category.errors.messages.values.flatten
        my_redirect_to new_category_question_path
      end
    end

  end

 
  private

  def allowed_params
    params.require(:category_form).permit(:value).to_h if params[:category_form].present?
  end

  
end
