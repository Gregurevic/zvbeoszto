class ApplicationController < ActionController::Base
  private

  def admin_access
    unless current_user.is_admin?
      redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
    end
  end
end
