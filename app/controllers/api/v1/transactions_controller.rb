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
end
