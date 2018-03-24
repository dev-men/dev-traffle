class User::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = current_user.products.paginate(:page => params[:page], :per_page => 9)
  end

  def new
    @product = Product.new
    4.times{ @product.images.build }
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @count =  4
    @count = @count - @product.images.count
    @count.times{ @product.images.build }
  end

  def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
         flash[:notice] = "Item has been updated!"
         redirect_to user_products_path
      else
         render 'edit'
      end
  end

  def create
    #debugger
    @product = Product.new(product_params)
    if user_signed_in?
      @product.imageable_id = current_user.id
      @product.imageable_type = "User"
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to user_dashboard_path(current_user), notice: "Your Product is submitted. You will be notified after Admin approval"  }
        format.json { render :show, status: :created, location: @product }
      else
        4.times{ @product.images.build }
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def approved
    @products = current_user.products.where(approve: true).paginate(:page => params[:page], :per_page => 9)
  end

  def unapproved
    @products = current_user.products.where(approve: false).paginate(:page => params[:page], :per_page => 9)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:category, :title, :total_tickets, :sold_tickets, :short_description, :long_description, :price,
                                      :approve, :hot, :count_down, :user_id, :admin_id,
                                      images_attributes: [:id, :avatar, :product_id])
    end
end
