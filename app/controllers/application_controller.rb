class ApplicationController < ActionController::Base
use Rack::Cors
# use Rack::Sendfile
# use Rack::Runtime
# use Rack::MethodOverride
# use ActionDispatch::RequestId
# use ActionDispatch::RemoteIp
# use Sprockets::Rails::QuietAssets
# use Rails::Rack::Logger
# use WebConsole::Middleware
# use ActionDispatch::DebugExceptions
# use ActionDispatch::Callbacks
# use ActiveRecord::Migration::CheckPending
# use ActionDispatch::Cookies
# use ActionDispatch::Session::CookieStore
# use ActionDispatch::Flash
# use Rack::Head
# use Rack::ConditionalGet
# use Rack::ETag
# use Warden::Manager
# use OmniAuth::Strategies::Facebook
# use OmniAuth::Strategies::Twitter

  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_carts_count
  before_action :set_notifications
  before_action :set_user_tickets_count

  protected
    def auth_admin
      if user_signed_in?
        redirect_to  errors_path
        flash[:alert] = nil
        flash[:notice] = nil
      end
    end
    def auth_user
      if admin_signed_in?
        redirect_to root_path
        flash[:alert] = nil
        flash[:notice] = nil
      end
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nick_name, :gender, :dob, :number, :city, :state, :zip, :address, :country, :price, :avatar, :balance])
    end

    def set_carts_count
      total_price_in_cart = 0.0
      if user_signed_in?
        @carts = Cart.where(:user_id => current_user.id) #if user_signed_in?
        @count = @carts.count
        if @count > 0
          @carts.each do |f|
            total_price_in_cart = total_price_in_cart + f.total_price
          end
        end
      end

      session[:cart_price] = total_price_in_cart
      session[:cart_count] = @count
    end

    def set_notifications
      if user_signed_in?

         @current_user_products = current_user.products
         @count = @current_user_products.count
         if @count > 0
           @current_user_products.each do |cp|
             current_product_id = cp.id
             current_user_id = current_user.id
             current_user_name = current_user.name
             #All tickets are sold and Count down time is over
             if cp.count_down < Time.current && cp.sold_tickets == cp.total_tickets
               if Notification.where("user_id = ? AND product_id = ? AND category = ? ", current_user.id,cp.id,2).first == nil
                   set_description = current_user_name + " your product " + cp.title + " all tickets are sold and time is over. It's time to select a winner"
                   set_notification = Notification.new(:user_id => current_user_id, :product_id => current_product_id, :category => 2, :description => set_description)
                   set_notification.save
               end
             elsif cp.count_down < Time.current && cp.sold_tickets < cp.total_tickets
               if Notification.where("user_id = ? AND product_id = ? AND category = ? ", current_user.id,cp.id,3).first == nil
                   set_description = current_user_name + " your product " + cp.title + " all tickets are not sold yet. But time is over. It's time to select a winner or extend the product time."
                   set_notification = Notification.new(:user_id => current_user_id, :product_id => current_product_id, :category => 3, :description => set_description)
                   set_notification.save
               end
             elsif cp.count_down > Time.current && cp.sold_tickets == cp.total_tickets
               if Notification.where("user_id = ? AND product_id = ? AND category = ? ", current_user.id,cp.id,4).first == nil
                   set_description = current_user_name + " your product " + cp.title + " all tickets are sold. It's time to select a winner."
                   set_notification = Notification.new(:user_id => current_user_id, :product_id => current_product_id, :category => 4, :description => set_description)
                   set_notification.save
               end
             end
           end
         end
         @current_user_notifications = current_user.notifications.where(:read => false).order("id DESC")
      end
    end


    def set_user_tickets_count
      if user_signed_in?
        @user_no_of_tickets = current_user.tickets.count
      end
    end
end
