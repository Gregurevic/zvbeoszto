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
      redirect_to applicants_path
      flash[:success] = 'A kurzust sikeresen regisztrálta.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A regisztráció sikertelen!'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    course = Course.find(params[:id])
    course.update(course_params)
    if course.save
      redirect_to applicants_path
      flash[:alert] = 'A kurzus adatmódosítása sikeres.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A kurzus adatmódosítása sikertelen!'
    end
  end

  def destroy
    Course.find(params[:id]).safe_delete
    redirect_to applicants_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :neptun)
  end
  
end
