require "application_system_test_case"

class UserListingsTest < ApplicationSystemTestCase
  setup do
    @user_listing = user_listings(:one)
  end

  test "visiting the index" do
    visit user_listings_url
    assert_selector "h1", text: "User Listings"
  end

  test "creating a User listing" do
    visit user_listings_url
    click_on "New User Listing"

    click_on "Create User listing"

    assert_text "User listing was successfully created"
    click_on "Back"
  end

  test "updating a User listing" do
    visit user_listings_url
    click_on "Edit", match: :first

    click_on "Update User listing"

    assert_text "User listing was successfully updated"
    click_on "Back"
  end

  test "destroying a User listing" do
    visit user_listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User listing was successfully destroyed"
  end
end
