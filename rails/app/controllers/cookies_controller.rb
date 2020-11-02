class CookiesController < ApplicationController

  # GET /cookies/preference/edit
  def edit
    @cooky = CookieForm.new(session[:cookie])
    cookie_preference = CookiePreference.new(session)
    @is_ga_disabled = cookie_preference.ga_disabled?
    @is_hj_disabled = cookie_preference.hj_disabled?
  end

  # PATCH/PUT /cookies/preference
  def update
    CookiePreference.new(session).set_preference(cooky_params)
    redirect_to root_path
  end

  private

  def cooky_params
    params.require(:choices).permit(:analytics, :hotjar)
  end
end
