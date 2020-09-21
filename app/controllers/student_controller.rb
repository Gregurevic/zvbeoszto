class StudentController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :schedule]
  before_action :admin_access, only: [:destroy]
  
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_path
      flash[:success] = 'Sikeres hallgatói regisztráció!'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A hallgatói regisztráció sikertelen!'
    end
  end

  def destroy
    redirect_to applicants_path
  end

  def profile
  end

  def schedule
  end

  private

  def student_params
    params.require(:student).permit(:name, :neptun, )
  end

end
