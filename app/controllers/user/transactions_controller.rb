class User::TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @transactions = current_user.transactions.order("id DESC")
  end
end
