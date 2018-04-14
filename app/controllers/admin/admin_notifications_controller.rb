class Admin::AdminNotificationsController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @notifications = current_admin.admin_notifications.order("id DESC").paginate(:page => params[:page], :per_page => 60)
  end

  def show_all
    @notification = AdminNotification.find(params[:id])
    @product = @notification.product
    @tickets = @product.tickets
  end

  def select_winner
    @notification = AdminNotification.find(params[:id])
    @product = @notification.product
    @tickets = @product.tickets
    if @product.winner_id == 0
      @product_sold_tickets = @product.sold_tickets
      @tickets = Ticket.where(:product_id => @product.id)
      num = Random.new
      @ran = num.rand(0..@product_sold_tickets-1)
      @winner = @tickets[@ran].user
      @winner_id = @winner.id
      @product.winner_id = @winner_id
      @product.save

      @notification.read = true
      @notification.save

      set_description_of_notification = @winner.name + " you WON the prize"
      @notification_to_winner = Notification.new(:user_id => @winner_id, :product_id => @product.id, :category => 6, :description => set_description_of_notification)
      @notification_to_winner.save

      #Mailer configuration for Winner
      @winner_profile = User.find_by_id(@winner_id)
      @drawn_product = Product.find_by_id(@product)
      WinnerMailer.send_mail_to_winner(@winner_profile, @drawn_product).deliver_now

      @tickets = @product.tickets
      @tickets.each do |t|
        @user = t.user
        if @user.id != @winner_profile.id
          WinnerMailer.send_mail_to_other(@user, @drawn_product, @winner_profile).deliver_later!(wait: 1.minute)
        end
      end

      flash[:notice] = "winner selected Successfully"
    else
      flash[:alert] = "winner for this product is already selected"
      redirect_to root_path
    end
  end
end
