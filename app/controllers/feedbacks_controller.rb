# frozen_string_literal: true

class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show edit update destroy]
  before_action :set_request, only: %i[new show create edit update destroy]

  # GET /feedbacks or /feedbacks.json
  def index
    @feedbacks = Feedback.all if current_user_account.admin?
    @feedbacks = Feedback.where(request_id: current_user_account.requests.ids) unless current_user_account.admin?
  end

  # GET /feedbacks/1 or /feedbacks/1.json
  def show; end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit; end

  # POST /feedbacks or /feedbacks.json
  def create
    @feedback = Feedback.new(observations: feedback_params.values[0], satisfaction: params[:satisfaction],
                             request_id: feedback_params.values[1])
    @request = @feedback.request
    respond_to do |format|
      if @feedback.save
        RequestMailer.feedback_sent(@request).deliver_later
        format.html { redirect_to root_path, notice: 'Feedback enviado.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1 or /feedbacks/1.json
  def update
    newfeedback = ActionController::Parameters.new(observations: feedback_params.values[0], satisfaction: params[:satisfaction]).permit(
      :observations, :satisfaction
    )
    respond_to do |format|
      if @feedback.update(newfeedback)
        format.html { redirect_to feedback_url(@feedback), notice: 'Feedback actualizado.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1 or /feedbacks/1.json
  def destroy
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback eliminado.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Set request to use
  def set_request
    @request ||= Request.find(params[:request_id]) if params[:request_id]
  end

  # Only allow a list of trusted parameters through.
  def feedback_params
    params.require(:feedback).permit(:observations, :satisfaction, :request_id)
  end
end
