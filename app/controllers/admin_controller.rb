class AdminController < ActionController::Base
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
  	  flash[:error] = 'You do not have access to this content!'
  	  redirect_to root_url
  	end
  end
  
end
