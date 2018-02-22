class AgeQuestionsController < ApplicationController

  before_action :require_asker, only: [:new, :create]
  after_action :save_asker, only: [:create]

  def new
    @age = new_and_download(@asker)
  end

  def create
    @age = new_from_params
    if @age.valid?
      populate_asker(@age, @asker)
      redirect_to_next_question(request)
    else
      save_asker
      populate_errors(flash)
      redirect_to_same_page
    end
  end
 
  private

  def populate_asker(age, asker)
    AgeService.new.upload(age, asker)
  end

  def redirect_to_next_question(request)
    redirect_to QuestionManager.new.getNextPath(request.referer, @age)
  end

  def redirect_to_same_page
    redirect_to new_age_question_path
  end

  def new_from_params
    AgeForm.new(allowed_params)
  end

  def new_and_download(asker)
    return AgeService.new.new_and_download(asker)
  end

  def allowed_params
    params.require(:age_form).permit(:number_of_years).to_h
  end

  def populate_errors(flash)
    flash[:error] = @age.errors.messages.values.flatten
  end

end
