class User::NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = current_user.notifications.order("id DESC")
  end
  def update
    if params[:key].to_i == 1
      update_notification_obj = Notification.find_by_id(params[:id])
      update_notification_obj.read = true
      if update_notification_obj.save
        redirect_to user_product_path(update_notification_obj.product_id)
      end
    elsif params[:key].to_i == 5
      update_notification_obj = Notification.find_by_id(params[:id])
      update_notification_obj.read = true
      if update_notification_obj.save
        redirect_to user_product_path(update_notification_obj.product_id)
      end
    elsif params[:key].to_i == 6
       update_notification_obj = Notification.find_by_id(params[:id])
       redirect_to user_notification_path(update_notification_obj.product_id)
    end
  end

  def tickets
    @notification = Notification.find_by_id(params[:id])
    @product = Product.find(@notification.product_id)
    @tickets = @product.tickets
  end

  def select_winner
     @notification = Notification.find_by_id(params[:id])
     product_id = @notification.product_id
     @product = Product.find_by_id(product_id)
     if @product.winner_id == 0
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

       set_description_of_notification = @winner.name + " you WON the prize"
       @notification_to_winner = Notification.new(:user_id => @winner_id, :product_id => product_id, :category => 6, :description => set_description_of_notification)
       @notification_to_winner.save

       #Mailer configuration for Winner
       @winner_profile = User.find_by_id(@winner_id)
       @drawn_product = Product.find_by_id(product_id)
       WinnerMailer.send_mail_to_winner(@winner_profile, @drawn_product).deliver_now

       @tickets = @product.tickets
       @tickets.each do |t|
         @user = t.user
         OthersMailer.send_to_product_other(@user, @drawn_product, @winner_profile).deliver_later!(wait: 1.minute)
       end
       @notification.read = true
       @notification.save
       flash[:notice] = "winner selected Successfully"
     else
       flash[:alert] = "winner for this product is already selected"
       redirect_to root_path
     end
  end

  def select_one_option
    @notification_id = params[:id]
    @notification = Notification.find_by_id(params[:id])
    @notification.read = true
    @notification.save
    @product_id = @notification.product_id
  end

  def show
    @notification = Notification.find(params[:id])
    @product = Product.find(@notification.product_id)
  end

  def received
    @product = Product.find(params[:pid])
    @owner = User.find(@product.imageable_id)
    @total = @product.sold_tickets * @product.ticket_price
    @admin_revenue = @total*0.1
    @owner_revenue = @total - @admin_revenue
    @owner.balance = @owner.balance + @owner_revenue
    @owner.save
    @notification = Notification.find(params[:nid])
    @notification.read = true
    @notification.save
    redirect_to root_path
  end

  def read
    @notification = Notification.find(params[:id])
    @notification.read = true
    @notification.save
    redirect_to user_dashboard_path
  end
end
