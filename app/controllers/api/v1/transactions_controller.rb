class Api::V1::TransactionsController < ApplicationController

   def index
     begin
       @user = User.find_by_email(params[:user_email])
       if @user
         @all_transactions = Transaction.where(:user_id => @user.id)
         render json: {:result => @all_transactions.as_json()}, status: 200
       else
         render json:  "-1", status: 200
       end
     rescue
       render json:  "-2", status: 200
     end
   end

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

   def verify
     begin
       @user = User.find_by_email(params[:user_email])
       paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
       transactions = PaystackTransactions.new(paystackObj)
       transaction_reference = params[:reference]
       transaction_access_code = params[:access_code]
       result = transactions.verify(transaction_reference)
       if result['status'] == true && result['data']['status'] == 'success'
         amount = result['data']['amount'].to_i / 100
         transaction_history = Transaction.new(:reference => result['data']['reference'], :access_code => transaction_access_code, :amount => amount, :paystack_transaction_id => result['data']['id'], :user_id => @user.id)
         transaction_history.save
         @user.wallet = @user.wallet + amount
         @user.save
         render json: { :user => @user.as_json(:except => [:approve, :created_at, :updated_at, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :uid, :provider], :include => [:customer], :methods => [:avatar_url])}, status: 200
       else
         render json:  "-1", status: 200
       end
     rescue
       render json:  "-2", status: 200
     end
   end
end
