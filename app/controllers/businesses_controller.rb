class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  before_action :set_location, only: [:show, :edit, :update, :destroy, :index, :create, :new]

  layout "business"

  after_action :verify_authorized, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  after_action :verify_policy_scoped, only: :my_services

  # GET /businesses
  # GET /businesses.json
  def index
    
    if params.has_key?(:category)
      @category = Category.find_by_name(params[:category])
      @businesses = Business.where(location_id: @location, category: @category).page(params[:page]).per(5)
    elsif params.has_key?(:location_id)
      @businesses = Business.where(location_id: @location).page(params[:page]).per(5)
    else
      @businesses = Business.all.page(params[:page]).per(5)
    end

    authorize @businesses

    if params[:search]
      @search_term = params[:search]
      @businesses = @businesses.search_by(@search_term)
    end
  end

  def my_services
    @businesses = policy_scope(Business).page(params[:page]).per(5)
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @page_title = @business.name
    @ratings = Rating.where(business_id: @business.id).order("created_at DESC")

    if @ratings.blank?
      @avg_rating = 0
    else
      @avg_rating = @ratings.average(:stars).round(2)
    end

    authorize @business
  end

  # GET /businesses/new
  def new
    @business = Business.new
    authorize @business
  end

  # GET /businesses/1/edit
  def edit
    authorize @business
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)
    @business.user_id = current_user.id
    @business.location_id = @location.id
    authorize @business

    respond_to do |format|
      if @business.save
        format.html { redirect_to @location, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    @business = Business.find(params[:id])
    authorize @business
    if @business.update(business_params)
      redirect_to [@location, @business]
    else
      render :edit
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business = Business.find(params[:id])
    authorize @business
    @business.destroy
    respond_to do |format|
      format.html { redirect_to location_businesses_url, notice: 'Business was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    def set_location
      @location = Location.friendly.find(params[:location_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :body, :main_image, :category_id, :location_id, :user_id)
    end
end
