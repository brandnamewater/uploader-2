require 'test_helper'

class SalesUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sales_upload = sales_uploads(:one)
  end

  test "should get index" do
    get sales_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_sales_upload_url
    assert_response :success
  end

  test "should create sales_upload" do
    assert_difference('SalesUpload.count') do
      post sales_uploads_url, params: { sales_upload: { video: @sales_upload.video } }
    end

    assert_redirected_to sales_upload_url(SalesUpload.last)
  end

  test "should show sales_upload" do
    get sales_upload_url(@sales_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_sales_upload_url(@sales_upload)
    assert_response :success
  end

  test "should update sales_upload" do
    patch sales_upload_url(@sales_upload), params: { sales_upload: { video: @sales_upload.video } }
    assert_redirected_to sales_upload_url(@sales_upload)
  end

  test "should destroy sales_upload" do
    assert_difference('SalesUpload.count', -1) do
      delete sales_upload_url(@sales_upload)
    end

    assert_redirected_to sales_uploads_url
  end
end
