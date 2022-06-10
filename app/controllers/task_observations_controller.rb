class TaskObservationsController < ApplicationController
  before_action :set_task_observation, only: %i[ show edit update destroy ]

  # GET /task_observations or /task_observations.json
  def index
    @task_observations = TaskObservation.all
  end

  # GET /task_observations/1 or /task_observations/1.json
  def show
  end

  # GET /task_observations/new
  def new
    @task_observation = TaskObservation.new
  end

  # GET /task_observations/1/edit
  def edit
  end

  # POST /task_observations or /task_observations.json
  def create
    @task_observation = TaskObservation.new(task_observation_params)

    respond_to do |format|
      if @task_observation.save
        format.html { redirect_to task_observation_url(@task_observation), notice: "Task observation was successfully created." }
        format.json { render :show, status: :created, location: @task_observation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_observations/1 or /task_observations/1.json
  def update
    respond_to do |format|
      if @task_observation.update(task_observation_params)
        format.html { redirect_to task_observation_url(@task_observation), notice: "Task observation was successfully updated." }
        format.json { render :show, status: :ok, location: @task_observation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_observations/1 or /task_observations/1.json
  def destroy
    @task_observation.destroy

    respond_to do |format|
      format.html { redirect_to task_observations_url, notice: "Task observation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_observation
      @task_observation = TaskObservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_observation_params
      params.require(:task_observation).permit(:description, :user_id, :task_id)
    end
end
