class User::RegistrationsController < Devise::RegistrationsController
  before_action :auth_user, only: [:new]
  # GET /resource/sign_up
  def new
    super
  end

  protected
    def after_update_path_for(resource)
      edit_user_registration_path()
    end
end
