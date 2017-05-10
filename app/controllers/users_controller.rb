class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  #rescue_from UserPolicy::AuthorizationError, with: :user_not_authorized

  def index
    @users = User.all
    #authorize User
    #authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(*policy(@user || User).permitted_attributes)
  end

  def user_not_authorized
    flash[:alert] = $!
    redirect_to (request.referrer || root_path)
  end

end
