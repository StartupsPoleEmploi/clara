class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    @cooky = CookieForm.new(session[:cookie])
  end

  # PATCH/PUT /cookies/preference
  def update

    p 'PARAMS -------------------------------------'
    p params 
    p 'END ----------------------------------------'

    #if params[:commit] == 'authorize_statistic' && 'authorize_navigation'
    #  p 'authorize_statistic ----------------------'
    #else
    #  p 'other ----------------' 
    #end


    session[:cookie] = cooky_params
    p :log
    p 'session[:cookie]'
    p session[:cookie]
    p 'END'
    
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cookies_form1, :cookies_form2).permit(:value, :value)
      #params.require(:cookies_form2).permit(:value)
    end
end
