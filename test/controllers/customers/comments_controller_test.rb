require 'test_helper'

class Customers::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get customers_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_comments_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get customers_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get customers_comments_update_url
    assert_response :success
  end
end
