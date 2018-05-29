require "application_system_test_case"

class FeatureCarrierWave::UsersTest < ApplicationSystemTestCase
  setup do
    @feature_carrier_wave_user = feature_carrier_wave_users(:one)
  end

  test "visiting the index" do
    visit feature_carrier_wave_users_url
    assert_selector "h1", text: "Feature Carrier Wave/Users"
  end

  test "creating a User" do
    visit feature_carrier_wave_users_url
    click_on "New Feature Carrier Wave/User"

    fill_in "Avatar", with: @feature_carrier_wave_user.avatar
    fill_in "Name", with: @feature_carrier_wave_user.name
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit feature_carrier_wave_users_url
    click_on "Edit", match: :first

    fill_in "Avatar", with: @feature_carrier_wave_user.avatar
    fill_in "Name", with: @feature_carrier_wave_user.name
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit feature_carrier_wave_users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
