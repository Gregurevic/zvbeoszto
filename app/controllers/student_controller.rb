class StudentController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :schedule]
  before_action :admin_access, only: [:destroy]
  
  def new
    users = User.where(rank: 'instructor').pluck(:rank_id, :email)
    instructors = Instructor.pluck(:id, :name)
    @instructors = []
    for i in 0..(instructors.length - 1)
      @instructors << [ instructors[i][1].to_s, users.detect{|u| u[0] == instructors[i][0]}[1].to_s ]
    end
    @courses = Course.pluck(:name, :neptun)
    @temp = params[:user_id]
    @student = Student.new
  end

  def create
    @student = Student.new(student_params.merge!(
               instructor_id: Instructor.where(name: student_params[:instructor_id][/(.*)\s/,1]).pluck(:id)[0],
               course_id: Course.where(neptun: student_params[:course_id].split.last[1..11]).pluck(:id)[0] ))
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
  end

  def update
    student = Student.find(params[:id])
    student.update(student_params)
    if student.save
      redirect_to applicants_path
      flash[:alert] = 'A kurzus adatmódosítása sikeres.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A kurzus adatmódosítása sikertelen!'
    end
  end

  def schedule
  end

  def destroy
    Student.find(params[:id]).safe_delete
    redirect_to applicants_path
  end

  private

  def student_params
    params.require(:student).permit(:name, :neptun, :instructor_id, :course_id)
  end

end
