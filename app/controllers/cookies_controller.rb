class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    @cooky = CookieForm.new(session[:cookie])
  end

  # PATCH/PUT /cookies/preference
  def update
    session[:cookie] = cooky_params
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cookie_form1).permit(:authorize_statistic, :forbid_statistic)
      params.require(:cookie_form2).permit(:authorize_navigation, :forbid_navigation)
    end
end
