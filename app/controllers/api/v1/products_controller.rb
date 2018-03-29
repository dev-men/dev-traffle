class Api::V1::ProductsController < ApplicationController
  require 'json'
  skip_before_action :authenticate_user_from_token!, :raise => false
  def index
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def real_estate
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def electronics
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def phone_and_tablets
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def automobiles
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def featured_items
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def promoted_items
    begin
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def search
    begin
      @products = []
      @p = Product.where("sold_tickets < total_tickets AND count_down > ? AND approve = ? AND title LIKE ?", Time.current, true, "%#{params[:search]}%").order("count_down ASC").paginate(:page => params[:page], :per_page => 30)
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
      render json: { :products => @products.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
    rescue
      render json: "-2", status: 200
    end
  end

  def create
    begin
      @user = User.find_by_email(params[:user_email])
      if @user
        @product = Product.new(product_params)
        @product.title = params[:title]
        @product.category = params[:category]
        @product.total_tickets = params[:total_tickets]
        @product.price = params[:price]
        @product.short_description = params[:short_description]
        @product.long_description = params[:long_description]
        @product.imageable_id = @user.id
        @product.imageable_type = "User"
        if @product.save(validate: false)
          params[:images].each do |act|
            @image = Image.new
            encoded_picture = act['avatar_file_data']
            content_type = act['avatar_content_type']
            image = Paperclip.io_adapters.for(encoded_picture)
            image.original_filename = act['avatar_file_name']
            @image.avatar = image
            @image.product_id = @product.id
            @image.save(validate: false)
          end
          render json: "1", status: 200
          #render json: { :product => @product.as_json(:except => [:created_at, :updated_at,:approve,:imageable_id, :imageable_type], :include => [:images => { :only => [:avatar_url], :methods => [:avatar_url]}]) }, status: 200
          #render json: { :product => @product.as_json() }, status: 200
        else
          render json: { :product => @product.errors.full_messages.as_json() }, status: 200
        end
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:category, :title, :total_tickets, :sold_tickets, :short_description, :long_description, :price,
                                    :approve, :hot, :count_down, :user_id, :admin_id,
                                    images_attributes: [:id, :avatar, :product_id])
  end
end
