require "test_helper"

class RequestDenyReasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_deny_reason = request_deny_reasons(:one)
  end

  test "should get index" do
    get request_deny_reasons_url
    assert_response :success
  end

  test "should get new" do
    get new_request_deny_reason_url
    assert_response :success
  end

  test "should create request_deny_reason" do
    assert_difference("RequestDenyReason.count") do
      post request_deny_reasons_url, params: { request_deny_reason: { description: @request_deny_reason.description, request_id: @request_deny_reason.request_id, user_id: @request_deny_reason.user_id } }
    end

    assert_redirected_to request_deny_reason_url(RequestDenyReason.last)
  end

  test "should show request_deny_reason" do
    get request_deny_reason_url(@request_deny_reason)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_deny_reason_url(@request_deny_reason)
    assert_response :success
  end

  test "should update request_deny_reason" do
    patch request_deny_reason_url(@request_deny_reason), params: { request_deny_reason: { description: @request_deny_reason.description, request_id: @request_deny_reason.request_id, user_id: @request_deny_reason.user_id } }
    assert_redirected_to request_deny_reason_url(@request_deny_reason)
  end

  test "should destroy request_deny_reason" do
    assert_difference("RequestDenyReason.count", -1) do
      delete request_deny_reason_url(@request_deny_reason)
    end

    assert_redirected_to request_deny_reasons_url
  end
end
