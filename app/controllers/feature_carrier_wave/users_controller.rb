class FeatureCarrierWave::UsersController < ApplicationController
  before_action :set_feature_carrier_wave_user, only: [:show, :edit, :update, :destroy]

  # GET /feature_carrier_wave/users
  # GET /feature_carrier_wave/users.json
  def index
    @feature_carrier_wave_users = FeatureCarrierWave::User.all
  end

  # GET /feature_carrier_wave/users/1
  # GET /feature_carrier_wave/users/1.json
  def show
  end

  # GET /feature_carrier_wave/users/new
  def new
    @feature_carrier_wave_user = FeatureCarrierWave::User.new
  end

  # GET /feature_carrier_wave/users/1/edit
  def edit
  end

  def confirm
    @feature_carrier_wave_user = FeatureCarrierWave::User.new(feature_carrier_wave_user_params)
    @feature_carrier_wave_user.avatar.cache! if params[:avatar]
  end

  # POST /feature_carrier_wave/users
  # POST /feature_carrier_wave/users.json
  def create
    @feature_carrier_wave_user = FeatureCarrierWave::User.new(feature_carrier_wave_user_params)

    @feature_carrier_wave_user.avatar.retrieve_from_cache! params[:cache][:avatar] if params.dig(:cache,:avatar)&.present?

    respond_to do |format|
      if @feature_carrier_wave_user.save
        format.html { redirect_to @feature_carrier_wave_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @feature_carrier_wave_user }
      else
        format.html { render :new }
        format.json { render json: @feature_carrier_wave_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feature_carrier_wave/users/1
  # PATCH/PUT /feature_carrier_wave/users/1.json
  def update
    respond_to do |format|
      if @feature_carrier_wave_user.update(feature_carrier_wave_user_params)
        format.html { redirect_to @feature_carrier_wave_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @feature_carrier_wave_user }
      else
        format.html { render :edit }
        format.json { render json: @feature_carrier_wave_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feature_carrier_wave/users/1
  # DELETE /feature_carrier_wave/users/1.json
  def destroy
    @feature_carrier_wave_user.destroy
    respond_to do |format|
      format.html { redirect_to feature_carrier_wave_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature_carrier_wave_user
      @feature_carrier_wave_user = FeatureCarrierWave::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_carrier_wave_user_params
      params.require(:feature_carrier_wave_user).permit(:name, :avatar)
    end
end
