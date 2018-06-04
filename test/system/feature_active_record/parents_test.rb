require "application_system_test_case"

class FeatureActiveRecord::ParentsTest < ApplicationSystemTestCase
  setup do
    @feature_active_record_parent = feature_active_record_parents(:one)
  end

  test "visiting the index" do
    visit feature_active_record_parents_url
    assert_selector "h1", text: "Feature Active Record/Parents"
  end

  test "creating a Parent" do
    visit feature_active_record_parents_url
    click_on "New Feature Active Record/Parent"

    fill_in "Name", with: @feature_active_record_parent.name
    click_on "Create Parent"

    assert_text "Parent was successfully created"
    click_on "Back"
  end

  test "updating a Parent" do
    visit feature_active_record_parents_url
    click_on "Edit", match: :first

    fill_in "Name", with: @feature_active_record_parent.name
    click_on "Update Parent"

    assert_text "Parent was successfully updated"
    click_on "Back"
  end

  test "destroying a Parent" do
    visit feature_active_record_parents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Parent was successfully destroyed"
  end
end
