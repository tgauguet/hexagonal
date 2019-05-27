class UsersController < ApplicationController

  def reconfirm
    @user = User.find_by_id(params[:id])
    @user.request.update(pending_reconfirmation: false)
    flash[:notice] = "Thank you for your confirmation !"
  end

end
