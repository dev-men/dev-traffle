class Api::V1::CartsController < ApplicationController
  def index
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @myProducts = @user.products.order('id desc')
        @purchasedProducts = []
        @tickets = @user.tickets.order('id desc')
        @tickets.each do |t|
          @purchasedProducts << t.product
        end
        render json: {
                        :myProducts => @myProducts.as_json(:except => [:price, :created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]),
                        :purchasedProducts => @purchasedProducts.as_json(:except => [:price, :created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}])
                    }, status: 200
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
      if @user
        @product = Product.find(params[:id])
        @number = params[:number].to_i
        @balance = @number*@product.ticket_price
        if @user.wallet > @balance
          @user.wallet = @user.wallet - @balance
          @user.save
          @product.sold_tickets = @product.sold_tickets + @number
          @product.save
          @number.to_i.times{
            tickets_purchased = Ticket.new(:user_id => @user.id, :product_id => @product.id, :price => @product.ticket_price)
            tickets_purchased.save
          }
          if @product.sold_tickets == @product.total_tickets
            if @product.imageable_type == "User"
              @u = User.find(@product.imageable_id)
              SoldTicketMailer.mail_send_to_product_owner(@u, @product).deliver_later!(wait: 1.minute)
            else
              @u = Admin.find(@product.imageable_id)
              SoldTicketMailer.mail_send_to_product_owner(@u, @product).deliver_later!(wait: 1.minute)
            end
          end
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
