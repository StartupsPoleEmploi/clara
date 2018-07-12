class GradeQuestionsController < ApplicationController

  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]
  
  def new
    @grade = GradeForm.new
    @grade.value = @asker.v_diplome
  end

  def create
    if params[:commit] == 'Revenir' 
      my_redirect_to QuestionManager.new.getPreviousPath(request.referer, @asker)
    else
      @grade = GradeForm.new(allowed_params)
      if @grade.valid?
        @asker.v_diplome = @grade.value if @grade.value.present?
        save_asker
        my_redirect_to QuestionManager.new.getNextPath(request.referer, @grade)
      else
        flash[:error] = @grade.errors.messages.values.flatten
        my_redirect_to new_grade_question_path
      end
    end
  end
 
  private

  def allowed_params
    params.require(:grade_form).permit(:value).to_h if params[:grade_form].present?
  end
end
