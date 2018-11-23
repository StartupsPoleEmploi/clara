class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    p 'cooky ----------------------'
    @cooky = CookieForm.new(session[:cookie])
  end

  # PATCH/PUT /cookies/preference
  def update
    p '@cooky ----------------------------'
    p @cooky

    p ':cookie ----------------------------'
    p :cookie

    p 'params ---------------------------'
    p params 

    p ':authorize_statistic -----------'
    p :authorize_statistic

    p ':forbid_statistic -----------'
    p :forbid_statistic

    p ':authorize_navigation -----------'
    p :authorize_navigation

    p ':forbid_navigation -----------'
    p :forbid_navigation

    session[:cookie] = cooky_params
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cookie_form).permit(:authorize_statistic, :forbid_statistic, :authorize_navigation, :forbid_navigation)
    end
end
