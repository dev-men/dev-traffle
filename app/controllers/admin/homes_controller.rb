class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @prodcuts = 0
    @approved = 0
    @unapproved = 0
    @total_admin_products = 0
    @total_users_products = 0
    @prodcuts = Product.all.count
    @approved = Product.where(approve: true).count
    @unapproved = Product.where(approve: false).count
    @total_admin_products = Product.where(imageable_type: "Admin").count
    @total_users_products = Product.where(imageable_type: "User").count
    @total_users = User.all.count
  end
end
