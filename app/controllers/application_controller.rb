class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  def downgrade
    current_user.update_attributes(role: 0) # 0 is default standard role
    current_user.wikis.update_all(private: false)
    redirect_to edit_user_registration_path
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to do that.'
    redirect_to (request.referrer || root_path)
  end

  #before_action :authenticate_user!
end
