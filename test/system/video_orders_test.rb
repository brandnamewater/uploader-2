require "application_system_test_case"

class VideoOrdersTest < ApplicationSystemTestCase
  setup do
    @video_order = video_orders(:one)
  end

  test "visiting the index" do
    visit video_orders_url
    assert_selector "h1", text: "Video Orders"
  end

  test "creating a Video order" do
    visit video_orders_url
    click_on "New Video Order"

    click_on "Create Video order"

    assert_text "Video order was successfully created"
    click_on "Back"
  end

  test "updating a Video order" do
    visit video_orders_url
    click_on "Edit", match: :first

    click_on "Update Video order"

    assert_text "Video order was successfully updated"
    click_on "Back"
  end

  test "destroying a Video order" do
    visit video_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video order was successfully destroyed"
  end
end
