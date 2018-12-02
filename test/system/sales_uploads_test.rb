require "application_system_test_case"

class SalesUploadsTest < ApplicationSystemTestCase
  setup do
    @sales_upload = sales_uploads(:one)
  end

  test "visiting the index" do
    visit sales_uploads_url
    assert_selector "h1", text: "Sales Uploads"
  end

  test "creating a Sales upload" do
    visit sales_uploads_url
    click_on "New Sales Upload"

    fill_in "Video", with: @sales_upload.video
    click_on "Create Sales upload"

    assert_text "Sales upload was successfully created"
    click_on "Back"
  end

  test "updating a Sales upload" do
    visit sales_uploads_url
    click_on "Edit", match: :first

    fill_in "Video", with: @sales_upload.video
    click_on "Update Sales upload"

    assert_text "Sales upload was successfully updated"
    click_on "Back"
  end

  test "destroying a Sales upload" do
    visit sales_uploads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Sales upload was successfully destroyed"
  end
end
