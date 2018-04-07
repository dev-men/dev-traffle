class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
    balance = PaystackBalance.new(paystackObj)
  	result = balance.get
  	@account_balance = result['data'][0]['balance']
    @account_balance = @account_balance / 100
    @prodcuts = 0
    @approved = 0
    @unapproved = 0
    @total_admin_products = 0
    @total_users_products = 0
    @total_users = 0
    @active = 0
    @blocked = 0
    @requests = 0
    @prodcuts = Product.all.count
    @approved = Product.where(approve: true).count
    @unapproved = Product.where(approve: false).count
    @total_admin_products = Product.where(imageable_type: "Admin").count
    @total_users_products = Product.where(imageable_type: "User").count
    @total_users = User.all.count
    @active = User.where(approve: true).count
    @blocked = User.where(approve: false).count
    @requests = Request.where(status: false).count
  end
end
