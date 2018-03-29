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
    @size = @products.count
  end

  def search
  end


  def play
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

end
