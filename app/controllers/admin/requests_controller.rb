class Admin::RequestsController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @requests = Request.where(status: false).order("id DESC").paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @request = Request.find(params[:id])
    @user = User.find(@request.user_id)
  end

  def transfer
    @request = Request.find(params[:id])
    @user = User.find(@request.user_id)
    @noti = Notification.new
    @noti.description = @user.name + " Your funds has been transfered to Your account successfully."
    @noti.user_id = @user.id
    @noti.category = 7
    @noti.save(validate: false)
    @request.status = true
    @request.save
    redirect_to root_path
  end
end
