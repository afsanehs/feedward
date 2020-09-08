require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get feedback_new_url
    assert_response :success
  end

  test "should get edit" do
    get feedback_edit_url
    assert_response :success
  end

  test "should get create" do
    get feedback_create_url
    assert_response :success
  end

  test "should get show" do
    get feedback_show_url
    assert_response :success
  end

  test "should get index" do
    get feedback_index_url
    assert_response :success
  end

end
