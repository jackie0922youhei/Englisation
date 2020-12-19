require 'test_helper'

class Customers::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get customers_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_relationships_destroy_url
    assert_response :success
  end
end
