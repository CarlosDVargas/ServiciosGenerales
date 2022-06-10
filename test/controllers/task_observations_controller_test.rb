require "test_helper"

class TaskObservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_observation = task_observations(:one)
  end

  test "should get index" do
    get task_observations_url
    assert_response :success
  end

  test "should get new" do
    get new_task_observation_url
    assert_response :success
  end

  test "should create task_observation" do
    assert_difference("TaskObservation.count") do
      post task_observations_url, params: { task_observation: { description: @task_observation.description, task_id: @task_observation.task_id, user_id: @task_observation.user_id } }
    end

    assert_redirected_to task_observation_url(TaskObservation.last)
  end

  test "should show task_observation" do
    get task_observation_url(@task_observation)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_observation_url(@task_observation)
    assert_response :success
  end

  test "should update task_observation" do
    patch task_observation_url(@task_observation), params: { task_observation: { description: @task_observation.description, task_id: @task_observation.task_id, user_id: @task_observation.user_id } }
    assert_redirected_to task_observation_url(@task_observation)
  end

  test "should destroy task_observation" do
    assert_difference("TaskObservation.count", -1) do
      delete task_observation_url(@task_observation)
    end

    assert_redirected_to task_observations_url
  end
end
