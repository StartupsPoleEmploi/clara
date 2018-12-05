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



    session[:cookie] = cooky_params
    p 'session[:cookie]'
    p session[:cookie]
    p 'END'
    
    redirect_to root_path
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:choices).permit(:analytics, :hotjar)
    end
end
