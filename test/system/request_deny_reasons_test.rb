require "application_system_test_case"

class RequestDenyReasonsTest < ApplicationSystemTestCase
  setup do
    @request_deny_reason = request_deny_reasons(:one)
  end

  test "visiting the index" do
    visit request_deny_reasons_url
    assert_selector "h1", text: "Request deny reasons"
  end

  test "should create request deny reason" do
    visit request_deny_reasons_url
    click_on "New request deny reason"

    fill_in "Description", with: @request_deny_reason.description
    fill_in "Request", with: @request_deny_reason.request_id
    fill_in "User", with: @request_deny_reason.user_id
    click_on "Create Request deny reason"

    assert_text "Request deny reason was successfully created"
    click_on "Back"
  end

  test "should update Request deny reason" do
    visit request_deny_reason_url(@request_deny_reason)
    click_on "Edit this request deny reason", match: :first

    fill_in "Description", with: @request_deny_reason.description
    fill_in "Request", with: @request_deny_reason.request_id
    fill_in "User", with: @request_deny_reason.user_id
    click_on "Update Request deny reason"

    assert_text "Request deny reason was successfully updated"
    click_on "Back"
  end

  test "should destroy Request deny reason" do
    visit request_deny_reason_url(@request_deny_reason)
    click_on "Destroy this request deny reason", match: :first

    assert_text "Request deny reason was successfully destroyed"
  end
end
