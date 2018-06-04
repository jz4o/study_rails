require 'test_helper'

class FeatureActiveRecord::ParentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feature_active_record_parent = feature_active_record_parents(:one)
  end

  test "should get index" do
    get feature_active_record_parents_url
    assert_response :success
  end

  test "should get new" do
    get new_feature_active_record_parent_url
    assert_response :success
  end

  test "should create feature_active_record_parent" do
    assert_difference('FeatureActiveRecord::Parent.count') do
      post feature_active_record_parents_url, params: { feature_active_record_parent: { name: @feature_active_record_parent.name } }
    end

    assert_redirected_to feature_active_record_parent_url(FeatureActiveRecord::Parent.last)
  end

  test "should show feature_active_record_parent" do
    get feature_active_record_parent_url(@feature_active_record_parent)
    assert_response :success
  end

  test "should get edit" do
    get edit_feature_active_record_parent_url(@feature_active_record_parent)
    assert_response :success
  end

  test "should update feature_active_record_parent" do
    patch feature_active_record_parent_url(@feature_active_record_parent), params: { feature_active_record_parent: { name: @feature_active_record_parent.name } }
    assert_redirected_to feature_active_record_parent_url(@feature_active_record_parent)
  end

  test "should destroy feature_active_record_parent" do
    assert_difference('FeatureActiveRecord::Parent.count', -1) do
      delete feature_active_record_parent_url(@feature_active_record_parent)
    end

    assert_redirected_to feature_active_record_parents_url
  end
end
