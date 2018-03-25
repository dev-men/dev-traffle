class User::SessionsController < Devise::SessionsController

  def create
    super
    if current_user.approve == false
      sign_out :user
      flash[:notice] = "Your account has been disabled. Please contact support for more information."
    end
  end
end
