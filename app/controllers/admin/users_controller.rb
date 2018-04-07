class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false
  before_action :find_user, only: [:show, :block_user, :remove_user, :unblock_user]
  before_action :find_product, only: [:product_detail]
  def index
    @users = User.where(approve: true)
  end

  def show
    @user_products = @user.products
  end

  def block_user
    @user.approve = false
    @user.save
    flash[:notice] = "User has been blocked by Admin!"
    redirect_to root_path
  end

  def remove_user
    @user.destroy
    flash[:notice] = "User has been removed by Admin!"
    redirect_to root_path
  end

  def all_blocked_users
    @users = User.where(approve: false)
  end

  def unblock_user
    if @user
      @user.approve = true
      @user.save
      flash[:notice] = "User has been UnBlocked!"
      redirect_to root_path
    else
    end
  end

  def product_detail
  end

  private
  def find_user
    @user = User.find(params[:id])
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
