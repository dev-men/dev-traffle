class Api::V1::CartsController < ApplicationController

  def create
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @product = Product.find(params[:id])
        @number = params[:number].to_i
        @balance = @number*@product.ticket_price
        if @user.wallet > @balance
          @user.wallet = @user.wallet - @balance
          @user.save
          @product.sold_tickets = @product.sold_tickets + @number
          @product.save
          render json: { :user => @user.as_json(:except => [:approve, :created_at, :updated_at, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :uid, :provider], :include => [:customer], :methods => [:avatar_url])}, status: 200
        else
          render json:  "0", status: 200
        end
      else
        render json:  "-1", status: 200
      end
    rescue
      render json:  "-2", status: 200
    end
  end

end
