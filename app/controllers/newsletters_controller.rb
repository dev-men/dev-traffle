class NewslettersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @register_users = User.where(:status => true).select("name, email")
    @subscribers = NewsLetter.where(:status => true).select("name, email")

  end

  def new
    @news_letter = NewsLetter.new
  end

  def create

    @news_letter = NewsLetter.new(:email => params[:email], :name => params[:name])
    if @news_letter.save
      flash[:notice] = "You have successfully subscribed to our News Letter!"
      redirect_to root_path
    else
      flash[:notice] = "You subscribtion is not done please try again!"
      redirect_to root_path
    end
  end

  private
  def set_params
    params.require(:news_letter).permit(:email, :name, :status)
  end
end
