require 'test_helper'

class Admin::AdminNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_admin_notifications_index_url
    assert_response :success
  end

  test "should get show_all" do
    get admin_admin_notifications_show_all_url
    assert_response :success
  end

  test "should get select_winner" do
    get admin_admin_notifications_select_winner_url
    assert_response :success
  end

end
