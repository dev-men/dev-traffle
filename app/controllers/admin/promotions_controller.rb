class Admin::PromotionsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false
  def new
    @promotion = Promotion.new
  end

  def create
   #debugger
    @promotion = Promotion.new(:subject => params[:promotion][:subject], :message => params[:promotion][:message])
    if @promotion.save
      @register_users = User.where(:status => true)
      @subscribers = NewsLetter.where(:status => true)
      @register_users.each do |u|
        AdminMailer.promotion_send(u, @promotion).deliver_later!(wait: 1.minute)
      end
      @subscribers.each do |u|
        AdminMailer.promotion_send(u, @promotion).deliver_later!(wait: 1.minute)
      end
      flash[:notice] = "Promotion is send to the Subscribers!"
      redirect_to root_path
    else
      flash[:notice] = "Promotion is not send to the Subscribers!"
      render 'new'
    end
  end

end
