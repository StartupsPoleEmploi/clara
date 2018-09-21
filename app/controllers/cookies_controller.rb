class CookiesController < ApplicationController
  before_action :set_cooky, only: [:show, :edit, :update, :destroy]

  # GET /cookies
  # GET /cookies.json
  def index
    @cookies = Cookie.all
  end

  # GET /cookies/1
  # GET /cookies/1.json
  def show
  end

  # GET /cookies/new
  def new
    @cooky = Cookie.new
  end

  # GET /cookies/1/edit
  def edit
  end

  # POST /cookies
  # POST /cookies.json
  def create
    @cooky = Cookie.new(cooky_params)

    respond_to do |format|
      if @cooky.save
        format.html { redirect_to @cooky, notice: 'Cookie was successfully created.' }
        format.json { render :show, status: :created, location: @cooky }
      else
        format.html { render :new }
        format.json { render json: @cooky.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cookies/1
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

  # DELETE /cookies/1
  # DELETE /cookies/1.json
  def destroy
    @cooky.destroy
    respond_to do |format|
      format.html { redirect_to cookies_url, notice: 'Cookie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cooky
      @cooky = Cookie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cooky_params
      params.require(:cooky).permit(:statistic, :navigation)
    end
end
