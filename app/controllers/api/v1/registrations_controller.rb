class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, :only => [:create, :social], :raise => false

   def create
     begin
       if params[:password] == params[:password_confirmation]
          @user = User.new
          @user.email = params[:email]
          @user.password = params[:password]
          @user.password_confirmation = params[:password_confirmation]
          @user.name = params[:name]
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

   def social
     begin
       @u = User.find_by_email(params[:email])
       if @u
         @u.uid = params[:uid]
         @u.provider = params[:provider]
         @u.image_url = params[:image_url]
         @u.name = params[:name]
         if @u.save
           render json: { :user => @u.as_json(:except => [:created_at, :updated_at]) }, status: 200
         else
           render json: {:errors => @u.errors.full_messages}, status: 200
         end
       elsif params[:password] == params[:password_confirmation]
          @user = User.new
          @user.email = params[:email]
          @user.uid = params[:uid]
          @user.provider = params[:provider]
          @user.image_url = params[:image_url]
          @user.password = params[:password]
          @user.password_confirmation = params[:password_confirmation]
          @user.name = params[:name]
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
