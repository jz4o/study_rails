class FeatureCarrierWave::UsersController < ApplicationController
  before_action :set_feature_carrier_wave_user, only: [:show, :edit, :update, :destroy]

  def index
    @feature_carrier_wave_users = FeatureCarrierWave::User.all
  end

  def show
  end

  def new
    @feature_carrier_wave_user = FeatureCarrierWave::User.new
  end

  def edit
  end

  def confirm
    @feature_carrier_wave_user = FeatureCarrierWave::User.new(feature_carrier_wave_user_params)
    @feature_carrier_wave_user.avatar.cache! if feature_carrier_wave_user_params[:avatar]
  end

  def create
    @feature_carrier_wave_user = FeatureCarrierWave::User.new(feature_carrier_wave_user_params)

    @feature_carrier_wave_user.avatar.retrieve_from_cache! params[:cache][:avatar] if params.dig(:cache,:avatar)&.present?

    if @feature_carrier_wave_user.save
      redirect_to @feature_carrier_wave_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @feature_carrier_wave_user.update(feature_carrier_wave_user_params)
      redirect_to @feature_carrier_wave_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feature_carrier_wave_user.destroy
    redirect_to feature_carrier_wave_users_url, notice: 'User was successfully destroyed.'
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
