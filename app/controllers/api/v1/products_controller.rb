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
end
