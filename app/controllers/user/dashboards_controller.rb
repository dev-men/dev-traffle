class User::DashboardsController < ApplicationController
  before_action :authenticate_user!
  def show
    @all_notifications = current_user.notifications
    @all_transactions = current_user.transactions
  end

  def change_image
    #debugger
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
