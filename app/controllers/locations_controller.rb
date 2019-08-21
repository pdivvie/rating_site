class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized, only: [:new, :edit, :create, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.order('name ASC')
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new

    authorize @location
  end

  # GET /locations/1/edit
  def edit
    authorize @location
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    authorize @location

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    authorize @location
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    authorize @location
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :display_in_navbar, :thumb_image)
    end
end
