class CategoryQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]  
  
  def new
    @category = CategoryForm.new
    @category.value = @asker.v_category 
  end

  def create
    if params[:commit] == 'Revenir' 
      redirect_to QuestionManager.new.getPreviousPath(request.referer, @asker)
    else
      @category = CategoryForm.new(allowed_params)
      @asker.v_category = @category.value
      save_asker
      if @category.valid?
        redirect_to QuestionManager.new.getNextPath(request.referer, @category)
      else
        flash[:error] = @category.errors.messages.values.flatten
        redirect_to new_category_question_path
      end
    end

  end

 
  private

  def allowed_params
    params.require(:category_form).permit(:value).to_h if params[:category_form].present?
  end

  
end
