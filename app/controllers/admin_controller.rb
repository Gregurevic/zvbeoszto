class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :admin_access
	
  def applicants
  end

  def current_schedule
  end

  def course_registration
  end

  private

  def admin_access
  	unless current_user.is_admin?
  	  redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
  	end
  end
  
end
