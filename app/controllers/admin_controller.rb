class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access
	
  def applicants
  end

  def current_schedule
  end

  def course_registration
  end  
end
