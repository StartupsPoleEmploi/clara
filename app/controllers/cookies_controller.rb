class CookiesController < ApplicationController
  before_action :set_cooky, only: [:edit, :update]


  # GET /cookies/preference/edit
  def edit
  end

  # PATCH/PUT /cookies/preference
  # PATCH/PUT /cookies/1.json
  def update
    respond_to do |format|
      if @cooky.update(cooky_params)
        format.html { redirect_to @cooky, notice: 'Cookie was successfully updated.' }
        format.json { render :show, status: :ok, location: @cooky }
      else
        format.html { render :edit }
        format.json { render json: @cooky.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cooky
      @cooky = CookieForm.new(session[:cookie])
      # @cooky = Cookie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cooky).permit(:statistic, :navigation)
    end
end
