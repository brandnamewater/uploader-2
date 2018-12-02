require 'test_helper'

class UserListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_listing = user_listings(:one)
  end

  test "should get index" do
    get user_listings_url
    assert_response :success
  end

  test "should get new" do
    get new_user_listing_url
    assert_response :success
  end

  test "should create user_listing" do
    assert_difference('UserListing.count') do
      post user_listings_url, params: { user_listing: {  } }
    end

    assert_redirected_to user_listing_url(UserListing.last)
  end

  test "should show user_listing" do
    get user_listing_url(@user_listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_listing_url(@user_listing)
    assert_response :success
  end

  test "should update user_listing" do
    patch user_listing_url(@user_listing), params: { user_listing: {  } }
    assert_redirected_to user_listing_url(@user_listing)
  end

  test "should destroy user_listing" do
    assert_difference('UserListing.count', -1) do
      delete user_listing_url(@user_listing)
    end

    assert_redirected_to user_listings_url
  end
end
