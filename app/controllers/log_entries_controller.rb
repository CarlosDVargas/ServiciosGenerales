class LogEntriesController < ApplicationController
  # GET /log_entries or /log_entries.json
  def index
    request = Request.find(params[:request_id])
    @log_entries = LogEntry.all.where(request_id: request.id)
    @log_entries = @log_entries.sort_by(&:created_at).reverse
  end
end
