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
            render json: { :user => @user.as_json(:except => [:created_at, :updated_at]), :include => [:customer]}, status: 200
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
   def update
    begin
      @u = User.find_by_email(params[:user_email])
      if @u
        @u.name = params[:name]
        @u.nick_name = params[:nick_name]
        @u.gender = params[:gender]
        @u.dob = params[:dob]
        @u.number = params[:number]
        @u.code = params[:code]
        @u.city = params[:city]
        @u.state = params[:state]
        @u.zip = params[:zip]
        @u.address = params[:address]
        @u.country = params[:country]
        if params[:password] == ""
          if @u.save
            render json: { :user => @u.as_json(:except => [:created_at, :updated_at]) }, status: 200
          else
            render json: {:errors => @u.errors.full_messages}, status: 200
          end
        elsif params[:password] == params[:password_confirmation]
          @u.password = params[:password]
          @u.password_confirmation = params[:password_confirmation]
          if @u.save
            render json: { :user => @u.as_json(:except => [:created_at, :updated_at]) }, status: 200
          else
            render json: {:errors => @u.errors.full_messages}, status: 200
          end
        else
          render json: "0", status: 200
        end
      else
        render json: "-1", status: 200
      end
    rescue
      render json: "-2", status: 200
    end
   end

   def profile_image
     begin
       @u = User.find_by_email(params[:user_email])
       if @u
        if params[:avatar]
          picture_params = params[:avatar]
          encoded_picture = picture_params[:avatar_file_data]
          content_type = picture_params[:content_type]
          image = Paperclip.io_adapters.for(encoded_picture)
          image.original_filename = picture_params[:avatar_file_name]
          @u.avatar = image
        end
        if @u.save
          render json: { :user => @u.as_json(:except => [:created_at, :updated_at]) }, status: 200
        else
          render json: {:errors => @u.errors.full_messages}, status: 200
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
     params.require(:user).permit(:email, :role, :password, :password_confirmation, :avatar)
   end
end
