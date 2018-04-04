class User::DashboardsController < ApplicationController
  before_action :authenticate_user!
  def show
    @t = current_user.tickets.count
    @e = current_user.tickets.distinct.pluck(:product_id).count
    @p = Product.where(winner_id: current_user.id).count
  end

  def wallet_charge
    if current_user.customer == nil
      redirect_to new_user_dashboard_path
    end
  end

  def new
    @customer = Customer.new
    @user = User.find(current_user.id)
  end

  def add
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
       session['payment'] = 1
    @auth_url = result['data']['authorization_url']
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

    redirect_to wallet_charge_user_dashboard_path(1)
  end

  def change_image
    @user = User.find_by_id(params[:id])
    @user.avatar = params[:user][:avatar]
    if @user.save
      flash[:notice] = "Your Image has been changed"
      redirect_to user_dashboard_path(@user.id)
    else
      flash[:notice] = "Your Image has not been changed"
      redirect_to user_dashboard_path(@user.id)
    end
  end
end
