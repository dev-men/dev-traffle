class HomesController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @products = Product.where("count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").limit(10)
    @size = @products.count
  end

  def search
  end

  def products
  end

  def contact
  end

  def play
    @products = Product.where("count_down > ? AND approve = ? AND category = ?", Time.current, true, "Featured Items").order("count_down ASC").limit(10)
    @size = @products.count
  end

  def how_to_play
  end

  def show
    @product = Product.find(params[:id])
    @products = Product.where("count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").limit(3)
    #debugger
  end

  def real_estate
    my_category = "Real Estate"
    @real_estates = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def electronics
    my_category = "Electronics"
    @electronics = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def phone_and_tablets
    my_category = "Phones And Tablets"
    @phones_and_tablets = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def automobiles
    my_category = "Automobiles"
    @automobiles = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def featured_items
    my_category = "Featured Items"
    @featured_items = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def promoted_items
    my_category = "Promoted Items"
    @promoted_items = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end

  def items_by_location
    my_category = "Items By Location"
    @items_by_location = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, my_category.downcase).order("count_down ASC").limit(12)
  end
end
