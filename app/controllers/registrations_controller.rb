class RegistrationsController < Devise::RegistrationsController

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :phone_number)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :phone_number, :current_password)
  end

end
