require 'test_helper'

class Customers::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get customers_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_favorites_destroy_url
    assert_response :success
  end
end
