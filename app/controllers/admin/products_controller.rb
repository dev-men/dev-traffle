class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user_from_token!, :raise => false
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 12)
  end

  def new
    @product = Product.new
    4.times{ @product.images.build }
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if admin_signed_in?
      @product.imageable_id = current_admin.id
      @product.imageable_type = "Admin"
      @product.approve = true
    end
    @product_total_tickets = params['product']['price'].to_i / params['product']['ticket_price'].to_i
    @product.total_tickets = @product_total_tickets
    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_path(current_user), notice: "Item created Successfully"  }
        format.json { render :show, status: :created, location: @product }
      else
        4.times{ @product.images.build }
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
      @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product_total_tickets = params['product']['price'].to_i / params['product']['ticket_price'].to_i
    @product.total_tickets = @product_total_tickets
    if @product.update(product_params)
       flash[:notice] = "Item has been updated!"
       redirect_to admin_product_path(@product)
    else
       render 'edit'
    end
  end

  def approve_product
    @product = Product.find(params[:id])
    @product.approve = true
    if @product.save
       user_id = @product.imageable_id
       product_id = @product.id
       user = User.where(:id => user_id).select("name").first
       user_name = user.name
       set_noti_description =  user_name + " your Product " + @product.title + " has been approved by admin."

       set_approve_notification = Notification.new(:user_id => user_id, :product_id => product_id, :category => 1, :description => set_noti_description)
       if set_approve_notification.save
         flash[:notice] = "Item Approved Successfully"
         redirect_to unapproved_products_admin_products_path
       end
    else
      flash[:alert] = "Item Not Approved"
      redirect_to admin_product_path(@product.id)
    end
  end

  def decline_product
    @product = Product.find(params[:id])
    @product.approve = nil
    if @product.save
       user_id = @product.imageable_id
       product_id = @product.id
       user = User.where(:id => user_id).select("name").first
       user_name = user.name
       set_noti_description =  user_name + " your Product " + @product.title + " has been decline by admin. Kindly review Your product and submit again."

       set_approve_notification = Notification.new(:user_id => user_id, :product_id => product_id, :category => 5, :description => set_noti_description)
       if set_approve_notification.save
         flash[:notice] = "Item decline Successfully"
         redirect_to root_path
       end
    else

    end
  end


  def approved_products
    @products = Product.where(approve: true).paginate(:page => params[:page], :per_page => 12)
  end

  def unapproved_products
    @products = Product.where(approve: false).paginate(:page => params[:page], :per_page => 12)
  end

  def my_products
    @products = Product.where(imageable_type: "Admin").paginate(:page => params[:page], :per_page => 12)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:category, :title, :total_tickets, :sold_tickets, :short_description, :long_description, :price, :ticket_price,
                                      :approve, :hot, :count_down, :user_id, :admin_id,
                                      images_attributes: [:id, :avatar, :product_id])
    end
end
