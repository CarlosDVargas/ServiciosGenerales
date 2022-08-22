# frozen_string_literal: true

class TaskObservationsController < ApplicationController
  before_action :set_task_observation, only: %i[show edit update destroy]

  # GET /observations or /observations.json
  def index
    @observations = TaskObservation.all
  end

  # GET /observations/1 or /observations/1.json
  def show; end

  # GET /observations/new
  def new
    @observation = TaskObservation.new
  end

  # GET /observations/1/edit
  def edit; end

  # POST /observations or /observations.json
  def create
    @observation = TaskObservation.new(task_observation_params)

    respond_to do |format|
      if @observation.save
        format.html do
          redirect_to task_observation_url(@observation), notice: 'Task observation was successfully created.'
        end
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1 or /observations/1.json
  def update
    respond_to do |format|
      if @observation.update(task_observation_params)
        format.html do
          redirect_to task_observation_url(@observation), notice: 'Task observation was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1 or /observations/1.json
  def destroy
    @observation.destroy

    respond_to do |format|
      format.html { redirect_to task_observations_url, notice: 'Task observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_observation
    @observation = TaskObservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_observation_params
    params.require(:observation).permit(:description, :user_id, :task_id)
  end
end
