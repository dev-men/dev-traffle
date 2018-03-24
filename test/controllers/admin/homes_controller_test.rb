require 'test_helper'

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_homes_index_url
    assert_response :success
  end

  test "should get approved_products" do
    get admin_homes_approved_products_url
    assert_response :success
  end

  test "should get unapproved_products" do
    get admin_homes_unapproved_products_url
    assert_response :success
  end

end
