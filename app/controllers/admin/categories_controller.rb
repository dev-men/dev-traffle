class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(permit_category)
    if @category.save
      flash[:notice] = "Category Successfully created"
      redirect_to admin_categories_path
    else
      render 'index'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.title = params[:category][:title]
    if @category.save
      flash[:notice] = "Category Updated created"
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end
  def destroy
    @categories = Category.all
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = "Category Successfully Delete"
      redirect_to admin_categories_path
    else
      render 'index'
    end
  end

  private
  def permit_category
    params.require(:category).permit(:title)
  end
end
