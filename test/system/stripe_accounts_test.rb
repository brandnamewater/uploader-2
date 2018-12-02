require "application_system_test_case"

class StripeAccountsTest < ApplicationSystemTestCase
  setup do
    @stripe_account = stripe_accounts(:one)
  end

  test "visiting the index" do
    visit stripe_accounts_url
    assert_selector "h1", text: "Stripe Accounts"
  end

  test "creating a Stripe account" do
    visit stripe_accounts_url
    click_on "New Stripe Account"

    click_on "Create Stripe account"

    assert_text "Stripe account was successfully created"
    click_on "Back"
  end

  test "updating a Stripe account" do
    visit stripe_accounts_url
    click_on "Edit", match: :first

    click_on "Update Stripe account"

    assert_text "Stripe account was successfully updated"
    click_on "Back"
  end

  test "destroying a Stripe account" do
    visit stripe_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stripe account was successfully destroyed"
  end
end
