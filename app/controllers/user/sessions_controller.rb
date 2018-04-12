class User::SessionsController < Devise::SessionsController
  before_action :auth_user
  # GET /resource/sign_in
  def new
    super
  end

  def create
    super
    if current_user.approve == false
      sign_out :user
      flash[:notice] = "Your account has been disabled. Please contact support for more information."
    end
  end
end
