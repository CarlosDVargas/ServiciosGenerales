class LogEntriesController < ApplicationController

  # GET /log_entries or /log_entries.json
  def index
    byebug
    request = Request.find(params[:request_id])
    @log_entries = LogEntry.all.where(request_id: request.id)
  end

end
