class EventsController < ApplicationController
  def create
    event_type = params[:type]

    case event_type
    when 'deposit'
      @account = Account.find_or_create_by!(account_id: params[:destination])
      @account.update(balance: @account.balance + params[:amount])
      render json: { destination: { id: @account.account_id.to_s, balance: @account.balance } }, status: :created
    when 'withdraw'
      @account = Account.find_by(account_id: params[:origin])
      if @account
        @account.update(balance: @account.balance - params[:amount])
        render json: { origin: { id: @account.account_id.to_s, balance: @account.balance } }, status: :created
      else
        render json: 0, status: :not_found
      end
    when 'transfer'
      @origin_account = Account.find_by(account_id: params[:origin])
      @destination_account = Account.find_or_create_by!(account_id: params[:destination])

      if @origin_account
        @origin_account.update(balance: @origin_account.balance - params[:amount])
        @destination_account.update(balance: @destination_account.balance + params[:amount])
        render json: { origin: { id: @origin_account.account_id.to_s, balance: @origin_account.balance }, destination: { id: @destination_account.account_id.to_s, balance: @destination_account.balance } }, status: :created
      else
        render json: 0, status: :not_found
      end
    end
  end

  def reset
    Account.delete_all
    render json: 'OK', status: :ok
  end
end
