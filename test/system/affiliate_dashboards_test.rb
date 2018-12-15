require "application_system_test_case"

class AffiliateDashboardsTest < ApplicationSystemTestCase
  setup do
    @affiliate_dashboard = affiliate_dashboards(:one)
  end

  test "visiting the index" do
    visit affiliate_dashboards_url
    assert_selector "h1", text: "Affiliate Dashboards"
  end

  test "creating a Affiliate dashboard" do
    visit affiliate_dashboards_url
    click_on "New Affiliate Dashboard"

    fill_in "Analytics", with: @affiliate_dashboard.analytics
    fill_in "Clients", with: @affiliate_dashboard.clients
    fill_in "Orders", with: @affiliate_dashboard.orders
    click_on "Create Affiliate dashboard"

    assert_text "Affiliate dashboard was successfully created"
    click_on "Back"
  end

  test "updating a Affiliate dashboard" do
    visit affiliate_dashboards_url
    click_on "Edit", match: :first

    fill_in "Analytics", with: @affiliate_dashboard.analytics
    fill_in "Clients", with: @affiliate_dashboard.clients
    fill_in "Orders", with: @affiliate_dashboard.orders
    click_on "Update Affiliate dashboard"

    assert_text "Affiliate dashboard was successfully updated"
    click_on "Back"
  end

  test "destroying a Affiliate dashboard" do
    visit affiliate_dashboards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Affiliate dashboard was successfully destroyed"
  end
end
