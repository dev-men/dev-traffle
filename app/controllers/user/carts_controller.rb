class User::CartsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :only => [:move_next], :raise => false
  before_action :authenticate_user!, :except => [:move_next]
  def index
    @carts = Cart.where(:user_id => current_user.id)
    @no_of_prizes = @carts.count
  end

  def add_to_cart
      price = params[:ticket][:price]
      price = price.to_i
      product_id = params[:id].to_i
      user_id =  current_user.id
      if Product.where("imageable_id = ? AND id = ?", user_id, product_id).first
        flash[:notice] = "You can't buy tickets for this product!"
        redirect_to root_path
      else

        product = Product.find_by(["id = ?", product_id])
        no_of_tickets = price / product.ticket_price
        remaining_tickets = product.total_tickets - product.sold_tickets

        if no_of_tickets <= remaining_tickets
           if Cart.where("user_id = ? AND product_id = ?", user_id, product_id).first
             update_cart = Cart.find_by("user_id = ? AND product_id = ?", user_id, product_id)
             update_cart.total_price = update_cart.total_price + price
             update_cart.save
           else
             new_cart = Cart.new(:user_id => current_user.id, :product_id => product_id, :total_price => price)
             new_cart.save
           end

           flash[:notice] = "Product is Successfully added to your cart!"
           redirect_to user_carts_path
        else
          flash[:alert] = "Only " + remaining_tickets.to_s + " tickets are remaining!"
          if params[:key].to_i == 1
            redirect_to root_path
          elsif params[:key].to_i == 2
            redirect_to real_estate_homes_path
          elsif params[:key].to_i == 3
            redirect_to electronics_homes_path
          elsif params[:key].to_i == 4
            redirect_to phone_and_tablets_homes_path
          elsif params[:key].to_i == 5
            redirect_to automobiles_homes_path
          elsif params[:key].to_i == 6
            redirect_to featured_items_homes_path
          elsif params[:key].to_i == 7
            redirect_to promoted_items_homes_path
          elsif params[:key].to_i == 8
            redirect_to items_by_location_homes_path
          end
        end
     end
  end


  def destroy
    @carts = Cart.where(:user_id => current_user.id)
    cart = Cart.find(params[:id])
    if cart.destroy
      flash[:notice] = "Item from cart is deleted!"
      redirect_to user_carts_path
    else
      flash[:notice] = "Item from cart is not deleted!"
      redirect_to user_carts_path
    end
  end

  def empty_cart
    @carts = Cart.where(:user_id => current_user.id)
    @count = @carts.count
    if @count != 0
      @carts.each do |f|
        f.destroy
      end
      flash[:notice] = "Your cart has been emptied!"
      redirect_to homes_path
    else
      flash[:notice] = "Your cart is already empty!"
      redirect_to homes_path
    end
  end

  def check_out
    if current_user.customer == nil
      redirect_to new_user_cart_path
    else
      @user_carts = current_user.carts
    end
  end


  def new
    @customer = Customer.new
    @user = User.find(current_user.id)
  end

  def create
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    paystack_customer = PaystackCustomers.new(paystackObj)
    result = paystack_customer.create(
      :first_name => params[:customer][:first_name],
      :last_name =>  params[:customer][:last_name],
      :phone => params[:customer][:phone],
      :email => params[:customer][:email]
    )
    customer = Customer.new(:first_name => params[:customer][:first_name], :last_name => params[:customer][:last_name], :email => params[:customer][:email], :phone => params[:customer][:phone])
    current_user.customer = customer

    redirect_to check_out_user_carts_path
  end

  def pay
    if current_user.carts.count > 0
      if params[:amount][:price].to_i == 0
        @carts = current_user.carts
        @total = 0.0
        @carts.each do |c|
          @total = @total + c.total_price
          product_id =  c.product_id
          product = Product.find(product_id)
          @total_tickets = c.total_price / product.ticket_price
          product.sold_tickets = product.sold_tickets + @total_tickets
          product.save
          @total_tickets = @total_tickets.round
          @total_tickets.times{
            tickets_purchased = Ticket.new(:user_id => current_user.id, :product_id => product_id, :price => product.ticket_price)
            tickets_purchased.save
          }
        end
        current_user.carts.destroy_all
        @user = User.find(current_user.id)
        @user.wallet = @user.wallet - @total
        @user.save
        redirect_to user_dashboard_path(current_user)
      else
        paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
        amount = params[:amount][:price].to_i
        amount = amount * 100
        transactions = PaystackTransactions.new(paystackObj)
        result = transactions.initializeTransaction(
         :amount => amount,
         :email => current_user.customer.email
        )
        session['access_code'] = result['data']['access_code']
        session['reference'] = result['data']['reference']
        session['payment'] = 0
        @auth_url = result['data']['authorization_url']
      end
    else
      flash[:alert] = "Your Playing cart is empty. Please load Your cart first."
      redirect_to root_path
    end
  end

  def move_next
    if user_signed_in?
      if session['payment'] == 1
        if session['reference'] == params['reference']
          transaction_reference = params['reference']
          paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
          transactions = PaystackTransactions.new(paystackObj)
          result = transactions.verify(transaction_reference)
          if result['status'] == true && result['data']['status'] == 'success'
            amount = result['data']['amount'].to_i / 100
            transaction_history = Transaction.new(:reference => result['data']['reference'], :access_code => session['access_code'], :amount => amount, :paystack_transaction_id => result['data']['id'], :user_id => current_user.id)
            transaction_history.save
            @user = User.find(current_user.id)
            @user.wallet = @user.wallet + amount
            @user.save
            flash[:notie] = "Your Transaction is completed!"
            redirect_to user_dashboard_path(current_user)
          else
            flash[:alert] = "Your Transaction is not completed!"
            redirect_to root_path
          end

        else
          flash[:alert] = "Your Transaction is not completed!"
          redirect_to root_path
        end
      elsif session['payment'] == 0
        if session['reference'] == params['reference']
          transaction_reference = params['reference']
          paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
      	  transactions = PaystackTransactions.new(paystackObj)
      	  result = transactions.verify(transaction_reference)
          if result['status'] == true && result['data']['status'] == 'success'
             amount = result['data']['amount'].to_i / 100
             transaction_history = Transaction.new(:reference => result['data']['reference'], :access_code => session['access_code'], :amount => amount, :paystack_transaction_id => result['data']['id'], :user_id => current_user.id)
             transaction_history.save
             user_carts = current_user.carts
             user_carts.each do |current_cart|
               product_id =  current_cart.product_id
               product = Product.find(product_id)
               @total_tickets = current_cart.total_price / product.ticket_price
               product.sold_tickets = product.sold_tickets + @total_tickets
               @total_tickets.round
               product.save
               @total_tickets.to_i.times{
                 tickets_purchased = Ticket.new(:user_id => current_user.id, :product_id => product_id, :price => product.ticket_price)
                 tickets_purchased.save
               }
             end
             @user = User.find(current_user.id)
             @user.wallet = 0
             @user.save
             current_user.carts.destroy_all

             flash[:notice] = "Your Transaction is successfully committed."
             redirect_to user_dashboard_path(current_user)
          else
            flash[:alert] = "Your Transaction is not completed!"
            redirect_to root_path
          end
        else
          flash[:alert] = "Your Transaction is not completed!"
          redirect_to root_path
        end
      end
    else
      redirect_to root_path
    end
  end

end
