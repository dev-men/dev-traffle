class User::NotificationsController < ApplicationController

  def update
    update_notification_obj = Notification.find_by_id(params[:id])
    update_notification_obj.read = true
    if update_notification_obj.save
      if params[:key].to_i == 1
         redirect_to user_product_path(update_notification_obj.product_id)
      end
    else
    end
  end
end
