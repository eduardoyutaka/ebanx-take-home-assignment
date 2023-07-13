class BalancesController < ApplicationController
  before_action :set_account

  def show
    if @account
      render json: @account.balance, status: :ok
    else
      render json: 0, status: :not_found
    end
  end

  private

  def set_account
    @account = Account.find_by(account_id: params[:account_id])
  end
end
