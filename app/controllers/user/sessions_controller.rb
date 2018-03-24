class User::SessionsController < Devise::SessionsController

  def create
    super
    #debugger
    if current_user.approve == false
      sign_out :user
      flash[:notice] = "Your account has been blocked by Admin."
    end
  end
end
