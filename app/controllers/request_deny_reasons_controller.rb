class RequestDenyReasonsController < ApplicationController
  before_action :set_request_deny_reason, only: %i[ show edit update destroy ]

  # GET /request_deny_reasons or /request_deny_reasons.json
  def index
    @request_deny_reasons = RequestDenyReason.all
  end

  # GET /request_deny_reasons/1 or /request_deny_reasons/1.json
  def show
  end

  # GET /request_deny_reasons/new
  def new
    @request_deny_reason = RequestDenyReason.new
  end

  # GET /request_deny_reasons/1/edit
  def edit
  end

  # POST /request_deny_reasons or /request_deny_reasons.json
  def create
    @request_deny_reason = RequestDenyReason.new(request_deny_reason_params)

    respond_to do |format|
      if @request_deny_reason.save
        format.html { redirect_to request_deny_reason_url(@request_deny_reason), notice: "Request deny reason was successfully created." }
        format.json { render :show, status: :created, location: @request_deny_reason }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request_deny_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_deny_reasons/1 or /request_deny_reasons/1.json
  def update
    respond_to do |format|
      if @request_deny_reason.update(request_deny_reason_params)
        format.html { redirect_to request_deny_reason_url(@request_deny_reason), notice: "Request deny reason was successfully updated." }
        format.json { render :show, status: :ok, location: @request_deny_reason }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request_deny_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_deny_reasons/1 or /request_deny_reasons/1.json
  def destroy
    @request_deny_reason.destroy

    respond_to do |format|
      format.html { redirect_to request_deny_reasons_url, notice: "Request deny reason was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_deny_reason
      @request_deny_reason = RequestDenyReason.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_deny_reason_params
      params.require(:request_deny_reason).permit(:description, :user_id, :request_id)
    end
end
