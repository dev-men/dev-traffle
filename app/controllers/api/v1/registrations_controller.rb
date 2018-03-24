class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :only => [:create], :raise => false

   def create
     begin
       if params[:password] == params[:password_confirmation]
          @user = User.new
          @user.email = params[:email]
          @user.password = params[:password]
          @user.password_confirmation = params[:password_confirmation]
          @user.first_name = params[:first_name]
          @user.last_name = params[:last_name]
          if @user.save
            render json: { :user => @user.as_json(:except => [:created_at, :updated_at]) }, status: 200
          else
            render json: {:errors => @user.errors.full_messages}, status: 200
          end
       else
        render json: "-1", status: 200
       end
     rescue
       render json: "-2", status: 200
     end
   end


   private
   def registrations_params
     params.require(:user).permit(:email, :role, :password, :password_confirmation)
   end
end
