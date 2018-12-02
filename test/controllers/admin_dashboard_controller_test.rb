require 'test_helper'

class AdminDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get Users" do
    get admin_dashboard_Users_url
    assert_response :success
  end

  test "should get Sellers" do
    get admin_dashboard_Sellers_url
    assert_response :success
  end

  test "should get Buyers" do
    get admin_dashboard_Buyers_url
    assert_response :success
  end

end
