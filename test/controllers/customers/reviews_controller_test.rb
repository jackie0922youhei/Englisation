require 'test_helper'

class Customers::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get customers_reviews_create_url
    assert_response :success
  end

  test "should get edit" do
    get customers_reviews_edit_url
    assert_response :success
  end

  test "should get update" do
    get customers_reviews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_reviews_destroy_url
    assert_response :success
  end

end
