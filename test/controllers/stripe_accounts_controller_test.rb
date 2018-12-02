require 'test_helper'

class StripeAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stripe_account = stripe_accounts(:one)
  end

  test "should get index" do
    get stripe_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_stripe_account_url
    assert_response :success
  end

  test "should create stripe_account" do
    assert_difference('StripeAccount.count') do
      post stripe_accounts_url, params: { stripe_account: {  } }
    end

    assert_redirected_to stripe_account_url(StripeAccount.last)
  end

  test "should show stripe_account" do
    get stripe_account_url(@stripe_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_stripe_account_url(@stripe_account)
    assert_response :success
  end

  test "should update stripe_account" do
    patch stripe_account_url(@stripe_account), params: { stripe_account: {  } }
    assert_redirected_to stripe_account_url(@stripe_account)
  end

  test "should destroy stripe_account" do
    assert_difference('StripeAccount.count', -1) do
      delete stripe_account_url(@stripe_account)
    end

    assert_redirected_to stripe_accounts_url
  end
end
