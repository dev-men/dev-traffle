class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false
  def index
    begin
      @products = []
      @p = Product.where("count_down > ? AND approve = ?", Time.current, true).order("count_down ASC").limit(30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def real_estate
    begin
      @products = []
      category = "Real Estate";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def electronics
    begin
      @products = []
      category = "Electronics";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def phone_and_tablets
    begin
      @products = []
      category = "Phones and Tablets";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def automobiles
    begin
      @products = []
      category = "Automobiles";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def featured_items
    begin
      @products = []
      category = "Featured Items";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def promoted_items
    begin
      @products = []
      category = "Promoted Items";
      @p = Product.where("count_down > ? AND approve = ? AND lower(category) = ?", Time.current, true, category.downcase).order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at], :include => [:images => { :only => [:id, :avatar_url, :created_at], :methods => [:avatar_url] }]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end
end
