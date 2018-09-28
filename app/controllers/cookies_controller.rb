class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    @cooky = CookieForm.new(session[:cookie])
  end

  # PATCH/PUT /cookies/preference
  def update
    session[:cookie] = cooky_params
    p '- - - - - - - - - - - - - - session[:cookie]- - - - - - - - - - - - - - - -' 
    pp session[:cookie]
    p ''
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cookie_form).permit(:disable_statistic, :disable_navigation)
    end
end
