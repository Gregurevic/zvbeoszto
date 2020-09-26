class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access
	
  def applicants
    #@pagy, @courses = pagy(Course.pluck(:id, :name, :neptun), items: 4)
    @pagy, @courses = pagy(Course.all, items: 4)
    @instructors = Instructor.pluck(:id, :name, :can_be_president, :can_be_secretary, :can_be_member)
    @examiners = Examiner.pluck(:course_id, :instructor_id)
    @students = Student.pluck(:id, :name, :neptun, :course_id, :instructor_id)
  end

  def current_schedule
  end

  def course_registration
  end  
end
