class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :raise => false
  def index
    @product = Product.first
    render json: { :product => @product.as_json(:except => [:created_at, :updated_at]) }, status: 200
  end
end
