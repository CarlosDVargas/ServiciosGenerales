class UserAccountsController < ApplicationController
  before_action :set_role, only: %i[new index]

  def index
    byebug
    @employees = UserAccount.where(campus: current_user_account.campus)
    if params[:q].present?
      @type ||= params[:q][:role_eq]
    end
    @employees_selected = if @role == 'worker'
                            @employees.where(role: 'worker')
                          else
                            @employees.where(role: 'admin')
                          end
    @query = @employees_selected.ransack(params[:q])
    @employees = @query.result
  end

  def search
    index
    render :index
  end

  # GET /user_accounts/1 or /user_accounts/1.json
  def show; end

  private

  def set_role
    @role = params[:role]
  end

end
