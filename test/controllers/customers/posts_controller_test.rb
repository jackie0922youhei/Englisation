require 'test_helper'

class Customers::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_posts_index_url
    assert_response :success
  end

  test "should get new" do
    get customers_posts_new_url
    assert_response :success
  end

  test "should get create" do
    get customers_posts_create_url
    assert_response :success
  end

  test "should get show" do
    get customers_posts_show_url
    assert_response :success
  end

  test "should get edit" do
    get customers_posts_edit_url
    assert_response :success
  end

  test "should get update" do
    get customers_posts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_posts_destroy_url
    assert_response :success
  end

end
