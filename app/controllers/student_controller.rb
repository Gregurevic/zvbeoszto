class StudentController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :update]
  before_action :admin_or_rid?, only: [:profile, :update]
  before_action :admin_access, only: [:destroy, :destroy_all]
  
  def new
    @instructors = instructors_to_list
    @courses = courses_to_list
    @temp = params[:user_id]
    @student = Student.new
  end

  def create
    @student = Student.new(student_params.merge!(
               instructor_id: instructor_id_from_list(student_params[:instructor_id]),
               course_id: course_id_from_list(student_params[:course_id]) ))
    if @student.save
      User.find(params[:user_id]).update(rank_id: Student.where(neptun: @student[:neptun]).pluck(:id)[0])
      redirect_to root_path
      flash[:success] = 'Sikeres hallgatói regisztráció!'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A hallgatói regisztráció sikertelen!'
    end
  end

  def profile
    @student = Student.find(params[:id])
    @instructors = instructors_to_list
    @courses = courses_to_list
  end

  def update
    @student = Student.find(params[:id])
    if @student.update( name: student_params[:name],
                        neptun: student_params[:neptun],
                        instructor_id: instructor_id_from_list(student_params[:instructor_id]),
                        course_id: course_id_from_list(student_params[:course_id]))
      redirect_to current_user.is_admin? ? applicants_path : edit_student_path(id: params[:id])
      flash[:alert] = 'A hallgató adatmódosítása sikeres.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A hallgató adatmódosítása sikertelen!'
    end
  end

  def destroy
    Student.find(params[:id]).delete_with_user
    redirect_to applicants_path
  end

  def destroy_all
    Student.new().delete_all_with_user
    redirect_to applicants_path
  end

  private

  def student_params
    params.require(:student).permit(:name, :neptun, :instructor_id, :course_id)
  end

  def admin_or_rid?
    unless current_user.is_admin? || current_user.rank_id.to_s == params[:id]
      redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
    end
  end

end
