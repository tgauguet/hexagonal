class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def dashboard
    @user = current_user
  end

  def update
    begin
      @user.skip_bio_validation = true
      @user.skip_phone_number_validation = true
      @user.update!(user_params)
      flash[:notice] = 'Congrats, your new address has been saved'
    rescue => e
      puts "ERROR IN UsersController METHOD update :\n#{e}"
      flash[:alert] = 'Error while saving your new address'
    end

    redirect_back fallback_location: root_path
  end

  def search_address
    begin
      query = params[:address].squish.tr(' ', '+') #replace spaces with '+'
      response = RestClient::Request.execute(
        method: :get,
        url: "https://api-adresse.data.gouv.fr/search/?q=#{query}&limit=1",
        headers: {}
      )
      respond_to do |format|
        format.json { render json: response }
      end
    rescue => e
      puts "ERROR IN UsersController METHOD search_address :\n#{e}"
      flash[:alert] = 'You might better fill the address field'
      redirect_back fallback_location: root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :city, :postal, :latitude, :longitude, :password, :password_confirmation, :bio, :phone_number, :current_password)
  end

end
