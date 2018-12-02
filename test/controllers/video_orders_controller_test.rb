require 'test_helper'

class VideoOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_order = video_orders(:one)
  end

  test "should get index" do
    get video_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_video_order_url
    assert_response :success
  end

  test "should create video_order" do
    assert_difference('VideoOrder.count') do
      post video_orders_url, params: { video_order: {  } }
    end

    assert_redirected_to video_order_url(VideoOrder.last)
  end

  test "should show video_order" do
    get video_order_url(@video_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_video_order_url(@video_order)
    assert_response :success
  end

  test "should update video_order" do
    patch video_order_url(@video_order), params: { video_order: {  } }
    assert_redirected_to video_order_url(@video_order)
  end

  test "should destroy video_order" do
    assert_difference('VideoOrder.count', -1) do
      delete video_order_url(@video_order)
    end

    assert_redirected_to video_orders_url
  end
end
