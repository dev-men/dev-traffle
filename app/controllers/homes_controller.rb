class HomesController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @products = []
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").limit(30)
    @count = 0
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
          if @count == 10
            break
          else
            @count = @count + 1
          end
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
        if @count == 10
          break
        else
          @count = @count + 1
        end
      end
    end
  end

  def terms
  end

  def search
    @cat = params[:home][:category]
    @search = params[:home][:search]
    @products = []
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND category like ? AND title like ?",
                       Time.current, true, "%#{@cat}%", "%#{@search}%").order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end


  def play
    @products = []
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def how_to_play
  end

  def show
    @product = Product.find(params[:id])
    @products = []
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").limit(10)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def real_estate
    @products = []
    category = "Real Estate";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def electronics
    @products = []
    category = "Electronics";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def phone_and_tablets
    @products = []
    category = "Phones and Tablets";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def automobiles
    @products = []
    category = "Automobiles";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def featured_items
    @products = []
    category = "Featured Items";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def promoted_items
    @products = []
    category = "Promoted Items";
    @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
    @p.each do |pro|
      if pro.imageable_type == "User"
        @u = User.find(pro.imageable_id)
        if @u && @u.approve
          @products << pro
        end
      elsif pro.imageable_type == "Admin"
        @products << pro
      end
    end
  end

  def raffle_items
    @raffle_products = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND raffle = ?", Time.current, true, true)
    @products = Product.where("winner_id > 0").order("updated_at DESC").limit(4)
    @winners_profile = []
    @products.each do |p|
      @user = User.find_by_id(p.winner_id)
      @winners_profile << @user
    end
  end

end
