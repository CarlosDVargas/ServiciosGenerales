require "application_system_test_case"

class LogEntriesTest < ApplicationSystemTestCase
  setup do
    @log_entry = log_entries(:one)
  end

  test "visiting the index" do
    visit log_entries_url
    assert_selector "h1", text: "Log entries"
  end

  test "should create log entry" do
    visit log_entries_url
    click_on "New log entry"

    fill_in "Entry message", with: @log_entry.entry_message
    fill_in "Request", with: @log_entry.request_id
    fill_in "User", with: @log_entry.user_id
    click_on "Create Log entry"

    assert_text "Log entry was successfully created"
    click_on "Back"
  end

  test "should update Log entry" do
    visit log_entry_url(@log_entry)
    click_on "Edit this log entry", match: :first

    fill_in "Entry message", with: @log_entry.entry_message
    fill_in "Request", with: @log_entry.request_id
    fill_in "User", with: @log_entry.user_id
    click_on "Update Log entry"

    assert_text "Log entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Log entry" do
    visit log_entry_url(@log_entry)
    click_on "Destroy this log entry", match: :first

    assert_text "Log entry was successfully destroyed"
  end
end
