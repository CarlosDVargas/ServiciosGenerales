class UserAccountsController < ApplicationController
  before_action :set_role, only: %i[new index search]
  before_action :set_user_account, only: %i[show edit update destroy]

  def index
    @employees = UserAccount.where(campus: current_user_account.campus)
    employees_selected = @employees.where(role: @role)
    @query = employees_selected.ransack(params[:q])
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
    @role = params[:role] if params[:role]
    if params[:q] && params[:q][:role_eq]
      if params[:q][:role_eq] == 'worker' || params[:q][:role_eq] == '1'
        @role = 1
      else
        @role = 0
      end
    end
  end

  def set_user_account
    @user_account = UserAccount.find(params[:id])
  end
end
