class Api::V1::CartsController < ApplicationController

  def create
    begin
      @user = User.find_by_email(params[:user_email])
      @amount = params[:amount].to_i
      if @user
        paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
        @amount = @amount * 100
        transactions = PaystackTransactions.new(paystackObj)
        @result = transactions.initializeTransaction(
             :amount => @amount,
             :email => @user.email
           )
        render json: {:result => @result.as_json()}, status: 200
      else
        render json:  "-1", status: 200
      end
    rescue
      render json:  "-2", status: 200
    end
  end

end
