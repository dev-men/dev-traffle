class User::NotificationsController < ApplicationController
  before_action :authenticate_user!
  def update
    update_notification_obj = Notification.find_by_id(params[:id])
    update_notification_obj.read = true
    if update_notification_obj.save
      if params[:key].to_i == 1
         redirect_to user_product_path(update_notification_obj.product_id)
      elsif params[:key].to_i == 5
         redirect_to user_product_path(update_notification_obj.product_id)
      end

    else
    end
  end

  def select_winner
    #debugger
     @notification = Notification.find_by_id(params[:id])
     product_id = @notification.product_id
     @product = Product.find_by_id(product_id)
     @product_sold_tickets = @product.sold_tickets
     @tickets = Ticket.where(:product_id => product_id)
     num = Random.new
     @ran = num.rand(0..@product_sold_tickets-1)
     @winner = @tickets[@ran].user

     @winner_id = @winner.id
     @product.winner_id = @winner_id
     @product.save

     update_notification_obj = Notification.find_by_id(params[:id])
     update_notification_obj.read = true
     update_notification_obj.save

     set_description_of_notification = @winner.name + " you have won the prize"
     @notification_to_winner = Notification.new(:user_id => @winner_id, :product_id => product_id, :category => 6, :description => set_description_of_notification)
     @notification_to_winner.save

     @notification.read = true
     @notification.save
     # product_total_tickets.time{
     #
     #
     # }
  end
end
