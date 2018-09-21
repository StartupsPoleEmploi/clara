class CookiesController < ApplicationController
  before_action :set_cooky, only: [:edit, :update]


  # GET /cookies/preference/edit
  def edit
  end

  # PATCH/PUT /cookies/preference
  def update
    p '- - - - - - - - - - - - - - @cooky- - - - - - - - - - - - - - - -' 
    pp @cooky
    p ''
    session[:cookie] = @cooky.attributes
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cookie_form).permit(:statistic, :navigation)
    end
end
