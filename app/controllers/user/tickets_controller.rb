class User::TicketsController < ApplicationController
  before_action :authenticate_user!

  def add_ticket
    #debugger
     price = params[:ticket][:price]
     price = price.to_i
     product_id = params[:id].to_i
     user_id =  current_user.id
     if Product.where("imageable_id = ? AND id = ?", user_id, product_id).first
       flash[:notice] = "You can't buy tickets for this product!"
       redirect_to root_path
     else
       no_of_tickets = price / 100
       product = Product.find_by(["id = ?", product_id])
       remaining_tickets = product.total_tickets - product.sold_tickets
       #debugger
       if no_of_tickets <= remaining_tickets
          product.sold_tickets = product.sold_tickets + no_of_tickets
          product.save

          no_of_tickets.times{
            ticket = Ticket.new(:user_id => user_id, :product_id => product_id, :price =>  100)
            ticket.save
          }

          flash[:notice] = "Successfully!"

          redirect_to root_path
       else
         #debugger
          flash[:alert] = "Only " + remaining_tickets.to_s + " tickets are remaining!"
          if params[:key].to_i == 1
            redirect_to root_path
          elsif params[:key].to_i == 2
            redirect_to real_estate_homes_path
          elsif params[:key].to_i == 3
            redirect_to electronics_homes_path
          elsif params[:key].to_i == 4
            redirect_to phone_and_tablets_homes_path
          elsif params[:key].to_i == 5
            redirect_to automobiles_homes_path
          elsif params[:key].to_i == 6
            redirect_to featured_items_homes_path
          elsif params[:key].to_i == 7
            redirect_to promoted_items_homes_path
          elsif params[:key].to_i == 8
            redirect_to items_by_location_homes_path
          end
       end
     end
     #debugger
  end


end
