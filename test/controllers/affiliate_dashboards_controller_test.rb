require 'test_helper'

class AffiliateDashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @affiliate_dashboard = affiliate_dashboards(:one)
  end

  test "should get index" do
    get affiliate_dashboards_url
    assert_response :success
  end

  test "should get new" do
    get new_affiliate_dashboard_url
    assert_response :success
  end

  test "should create affiliate_dashboard" do
    assert_difference('AffiliateDashboard.count') do
      post affiliate_dashboards_url, params: { affiliate_dashboard: { analytics: @affiliate_dashboard.analytics, clients: @affiliate_dashboard.clients, orders: @affiliate_dashboard.orders } }
    end

    assert_redirected_to affiliate_dashboard_url(AffiliateDashboard.last)
  end

  test "should show affiliate_dashboard" do
    get affiliate_dashboard_url(@affiliate_dashboard)
    assert_response :success
  end

  test "should get edit" do
    get edit_affiliate_dashboard_url(@affiliate_dashboard)
    assert_response :success
  end

  test "should update affiliate_dashboard" do
    patch affiliate_dashboard_url(@affiliate_dashboard), params: { affiliate_dashboard: { analytics: @affiliate_dashboard.analytics, clients: @affiliate_dashboard.clients, orders: @affiliate_dashboard.orders } }
    assert_redirected_to affiliate_dashboard_url(@affiliate_dashboard)
  end

  test "should destroy affiliate_dashboard" do
    assert_difference('AffiliateDashboard.count', -1) do
      delete affiliate_dashboard_url(@affiliate_dashboard)
    end

    assert_redirected_to affiliate_dashboards_url
  end
end
