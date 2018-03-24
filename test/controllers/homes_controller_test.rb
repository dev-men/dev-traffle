require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get homes_index_url
    assert_response :success
  end

  test "should get search" do
    get homes_search_url
    assert_response :success
  end

  test "should get products" do
    get homes_products_url
    assert_response :success
  end

end
