class InstructorController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :schedule]
  before_action :admin_access, only: [:destroy]
  before_action :construct_courses, only: [:create]
  
  def new
    @courses = courses_to_list
    @temp = params[:user_id]
    @instructor = Instructor.new
  end

  def create
    courses = instructor_params[:course_list].split(" ")
    @instructor = Instructor.new(instructor_params.permit(:name, :can_be_president, :can_be_secretary, :can_be_member))
    if @instructor.save
      instructor_id = Instructor.where(name: @instructor[:name]).pluck(:id)[0]
      User.find(params[:user_id]).update(rank_id: instructor_id)
      courses.each do |c|
        Examiner.create(course_id: Course.where(neptun: c).pluck(:id)[0], instructor_id: instructor_id)
      end
      redirect_to root_path
      flash[:success] = 'Sikeres oktatói regisztráció!'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Az oktatói regisztráció sikertelen!'
    end
  end

  def destroy
    Instructor.find(params[:id]).safe_delete
    redirect_to applicants_path
  end

  def profile
  end

  def schedule
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :can_be_president, :can_be_secretary, :can_be_member, :course_list)
  end

  def construct_courses
    if params[:instructor][:course_list].present?
      params[:instructor][:course_list].shift
      temp = []
      params[:instructor][:course_list].each do |c|
        temp << c.split.last[1..11] + " "
      end
      params[:instructor][:course_list] = temp.join
    else
      params[:instructor][:course_list] = ""
    end
  end

end
