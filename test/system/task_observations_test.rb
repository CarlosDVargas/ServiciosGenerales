require "application_system_test_case"

class TaskObservationsTest < ApplicationSystemTestCase
  setup do
    @task_observation = task_observations(:one)
  end

  test "visiting the index" do
    visit task_observations_url
    assert_selector "h1", text: "Task observations"
  end

  test "should create task observation" do
    visit task_observations_url
    click_on "New task observation"

    fill_in "Description", with: @task_observation.description
    fill_in "Task", with: @task_observation.task_id
    fill_in "User", with: @task_observation.user_id
    click_on "Create Task observation"

    assert_text "Task observation was successfully created"
    click_on "Back"
  end

  test "should update Task observation" do
    visit task_observation_url(@task_observation)
    click_on "Edit this task observation", match: :first

    fill_in "Description", with: @task_observation.description
    fill_in "Task", with: @task_observation.task_id
    fill_in "User", with: @task_observation.user_id
    click_on "Update Task observation"

    assert_text "Task observation was successfully updated"
    click_on "Back"
  end

  test "should destroy Task observation" do
    visit task_observation_url(@task_observation)
    click_on "Destroy this task observation", match: :first

    assert_text "Task observation was successfully destroyed"
  end
end
