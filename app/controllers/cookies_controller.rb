class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    @cooky = CookieForm.new(session[:cookie])
  end

  # PATCH/PUT /cookies/preference
  def update

    p 'params ---------------------------'
    p params 

    if params[:commit] == 'authorize_statistic' && 'authorize_navigation'
      p 'authorize_statistic ----------------------'
    else
      p 'other ----------------' 
    end


    session[:cookie] = cooky_params
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.permit(:authorize_statistic, :forbid_statistic, :authorize_navigation, :forbid_navigation)
    end
end
