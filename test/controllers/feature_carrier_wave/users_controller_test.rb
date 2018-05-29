require 'test_helper'

class FeatureCarrierWave::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feature_carrier_wave_user = feature_carrier_wave_users(:one)
  end

  test "should get index" do
    get feature_carrier_wave_users_url
    assert_response :success
  end

  test "should get new" do
    get new_feature_carrier_wave_user_url
    assert_response :success
  end

  test "should create feature_carrier_wave_user" do
    assert_difference('FeatureCarrierWave::User.count') do
      post feature_carrier_wave_users_url, params: { feature_carrier_wave_user: { avatar: @feature_carrier_wave_user.avatar, name: @feature_carrier_wave_user.name } }
    end

    assert_redirected_to feature_carrier_wave_user_url(FeatureCarrierWave::User.last)
  end

  test "should show feature_carrier_wave_user" do
    get feature_carrier_wave_user_url(@feature_carrier_wave_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_feature_carrier_wave_user_url(@feature_carrier_wave_user)
    assert_response :success
  end

  test "should update feature_carrier_wave_user" do
    patch feature_carrier_wave_user_url(@feature_carrier_wave_user), params: { feature_carrier_wave_user: { avatar: @feature_carrier_wave_user.avatar, name: @feature_carrier_wave_user.name } }
    assert_redirected_to feature_carrier_wave_user_url(@feature_carrier_wave_user)
  end

  test "should destroy feature_carrier_wave_user" do
    assert_difference('FeatureCarrierWave::User.count', -1) do
      delete feature_carrier_wave_user_url(@feature_carrier_wave_user)
    end

    assert_redirected_to feature_carrier_wave_users_url
  end
end
