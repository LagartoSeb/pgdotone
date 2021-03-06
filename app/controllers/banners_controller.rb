class BannersController < ApplicationController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /banners
  # GET /banners.json
  def index
    @banners = Banner.all
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
  end

  # GET /banners/new
  def new
    @banner = Banner.new
  end

  # GET /banners/1/edit
  def edit
  end

  # POST /banners
  # POST /banners.json
  def create
    last_order = Banner.select(:order).last
    params[:banner][:order]  = last_order.order + 1
    params[:banner][:master] = false
    @banner = Banner.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to admin_path notice: 'Banner fue creado exitósamente.' }
        format.json { render :show, status: :created, location: @banner }
      else
        format.html { render :new }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banners/1
  # PATCH/PUT /banners/1.json
  def update
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to admin_path, notice: 'Banner fue editado exitósamente.' }
        format.json { render :show, status: :ok, location: @banner }
      else
        format.html { render :edit }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Banner fue eliminado exitósamente.' }
      format.json { head :no_content }
    end
  end

  def flop
    banner = Banner.find(params[:id])
    banner.active = !banner.active
    banner.save

    redirect_to admin_path
  end

  def up_order
    banner = Banner.find(params[:id])
    banner.update_attributes(order: banner.order + 1)
    banner.save
    redirect_to admin_path
  end

  def down_order
    banner = Banner.find(params[:id])
    banner.update_attributes(order: banner.order - 1)
    banner.save
    redirect_to admin_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def banner_params
      params.require(:banner).permit(:active, :order, :video, :image, :background_image, :text, :master)
    end
end
