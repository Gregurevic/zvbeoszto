class CourseController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access

  def index
    redirect_to applicants_path
  end
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = 'A kurzust sikeresen regisztrálta.'
    else
      flash[:alert] = 'A regisztráció sikertelen!'
    end
  end

  def destroy
  end

  private

  def course_params
    params.require(:course).permit(:name, :neptun)
  end
  
end
