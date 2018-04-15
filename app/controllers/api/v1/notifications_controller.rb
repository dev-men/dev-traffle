class Api::V1::NotificationsController < ApplicationController
  def index
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @notifications = Notification.where(:user_id => @user.id).order('id desc')
        render json: {:result => @notifications.as_json()}, status: 200
      else
        render json:  "-1", status: 200
      end
    rescue
      render json:  "-2", status: 200
    end
  end
end
