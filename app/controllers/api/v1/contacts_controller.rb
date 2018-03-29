class Api::V1::ContactsController < ApplicationController

  def create
    begin
      @c = Contact.new
      @c.name = params[:name]
      @c.email = params[:email]
      @c.phone_no = params[:phone_no]
      @c.message = params[:message]
      if @c.save
        render json: "1", status: 200
      else
        render json: {:errors => @c.errors.full_messages}, status: 200
      end
    rescue
      render json: "-2", status: 200
    end
  end
end
