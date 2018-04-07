class Api::V1::CustomersController < ApplicationController

  def create
    begin
      @user = User.find_by_email(params[:user_email])
      if @user && @user.customer == nil
        paystackObj = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_PRIVATE_KEY'])
        paystack_customer = PaystackCustomers.new(paystackObj)
        result = paystack_customer.create(
          :first_name => params[:customer][:first_name],
          :last_name =>  params[:customer][:last_name],
          :phone => params[:customer][:phone],
          :email => params[:customer][:email]
        )
        @customer = Customer.new(:first_name => params[:first_name], :last_name => params[:last_name], :email => params[:email], :phone => params[:phone])
        @customer.user_id = @user.id
        if @customer.save
          render json: { :user => @user.as_json(:except => [:approve, :created_at, :updated_at, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :uid, :provider], :include => [:customer], :methods => [:avatar_url])}, status: 200
        else
          render json: {:errors => @customer.errors.full_messages}, status: 200
        end
      else
        render json:  "-1", status: 200
      end
    rescue
      render json:  "-2", status: 200
    end
  end

end
